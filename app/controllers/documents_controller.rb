class DocumentsController < ApplicationController
  def index
    @search = Document.search(params[:q])
    if params[:tag]
      @documents = Document.tagged_with(params[:tag])
      @page_title="Documents by Tag (" << params[:tag].upcase << ")"
    elsif params[:q]
      @documents=@search.result
      @page_title="Documents by Search Result"
    else
      @documents = Document.recently_added
      @page_title = "Recent Documents"
    end
  end

  def show
    @document = Document.find(params[:id])
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(params[:document])
    if @document.save
      redirect_to documents_path, :notice => "Successfully created document."
    else
      render :action => 'new'
    end
  end

  def edit
    @document = Document.find(params[:id])
  end

  def update
    @document = Document.find(params[:id])
    if @document.update_attributes(params[:document])
      redirect_to documents_path, :notice  => "Successfully updated document."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    redirect_to documents_url, :notice => "Successfully destroyed document."
  end
end
