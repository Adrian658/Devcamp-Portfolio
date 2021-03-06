class PortfoliosController < ApplicationController
	before_action :set_first_visit
	before_action :set_session_pages
	before_action :set_portfolio_item, only: [:edit, :show, :update, :destroy]
	access all: [:show, :index], user: {except: [:destroy, :new, :create, :update, :edit]}, site_admin: :all
	layout "portfolios"

	def index
		@portfolio_items = Portfolio.by_position
	end

	def sort
		params[:order].each do |key, value|
			Portfolio.find(value[:id]).update(position: value[:position])
		end

		render nothing: true
	end

	def new
		@portfolio_item = Portfolio.new
	end

	def create
	    @portfolio_item = Portfolio.new(portfolio_params)

	    respond_to do |format|
	      if @portfolio_item.save
	        format.html { redirect_to portfolios_path, notice: 'Portfolio item was successfully created.' }
	      else
	        format.html { render :new }
	      end
	    end
  	end

  	def edit
  	end

  	def update
	    respond_to do |format|
	      if @portfolio_item.update(portfolio_params)
	        format.html { redirect_to portfolios_path, notice: 'Portfolio item was successfully updated.' }
	      else
	        format.html { render :edit }
	      end
	    end
  	end

  	def show
  	end

  	def destroy
	    @portfolio_item.destroy
	    respond_to do |format|
	      format.html { redirect_to portfolios_url, notice: 'Record was successfully removed.' }
	    end
		end

  	private

  	#Require parameters for portfolio
  	def portfolio_params
  		params.require(:portfolio).permit(:title,
  										  :subtitle,
  										  :body,
												:main_image,
												:thumb_image,
  										  technologies_attributes: [:id, :name, :_destroy]
  										 )
  	end

		def set_portfolio_item
			@portfolio_item = Portfolio.find(params[:id])
		end

		def set_session_pages
      session[:first_visit_pages] = 2
		end
		
		def set_first_visit
			if session.has_key?(:first_visit_portfolio)
				if session[:first_visit_portfolio] == 1
					session[:first_visit_portfolio] = 2
				else
					session[:first_visit_portfolio] = 3
				end
			else
				session[:first_visit_portfolio] = 1
			end
		end

end
