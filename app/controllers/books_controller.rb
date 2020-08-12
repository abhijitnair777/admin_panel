class BooksController < ApplicationController

  # GET /products
  # GET /products.json
  def index
    search = params[:term].present? ? params[:term] : nil
    @books = if search
      Book.where("name LIKE ? OR price LIKE ?", "%#{search}%", "%#{search}%").order(created_at: :desc).page(params[:page])
      Book.search(search)
    else
      Book.all
    end    
  end

  # GET /products/1
  # GET /products/1.json
  def show
  	@book = Book.find(params[:id])
  	
    respond_to do |format|
      # AdminMailer.send_new_admin_message(@book).deliver!
      format.html
      format.pdf do
                render pdf: "Book No. #{@book.id}",
                page_size: 'A4',
                template: "books/show.html.erb",
                layout: "pdf.html",
                orientation: "Landscape",
                lowquality: true,
                zoom: 1,
                dpi: 75,
                disposition: 'inline',
                :margin => { :top => 5, :bottom => 0, :left => 0, :right => 0}

                # :footer => {:html => { :template => 'books/_footer.html.erb',
                #                        :layout   => 'pdf.html'}},
                # :header => {:html => { :template => 'books/_pdf_header.html.erb',
                #                        :layout   => 'pdf.html'}},                
                # :background => {:html => { :template => 'books/_background.html.erb',
                #                        :layout   => 'pdf.html'}}                          
      end
    end
  end

  def show_multiple
    @books = Book.find(params[:books])
        cpdf = CombinePDF.new
        @books.each do |book|
          @book = book
          pdfdata = WickedPdf.new.pdf_from_string(render_to_string('books/show',
           layout: "layouts/pdf.html"))
          
          cpdf << CombinePDF.parse(pdfdata)
        end
        send_data cpdf.to_pdf, filename: "combined.pdf", type: "application/pdf"
    #   end      
    # end  
  end

  private

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:name, :price, :category_id, authors_attributes: [:id, :first_name, :last_name, :email, :mobile],
       genres_attributes: [:id, :name])
    end
end
