class PagesController < ApplicationController
  def about
  	@about = Pages.where('title LIKE ?', 'About').first
  end

  def contact
  	@contact = Pages.where('title LIKE ?', 'Contact').first
  end

  def edit
  end

  def show
  end

  private
  def set_page
    @page = Page.find(params[:id])
  end

  def page_params
    params.require(:page).permit(:title, :content)
  end
end
