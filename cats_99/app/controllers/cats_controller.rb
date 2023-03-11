class CatsController < ApplicationController
    def index
        @cats = Cat.all
        render json: index
    end

    def show
        @cat = Cat.find(params[:id])
        render: show
    end

    def new
        @cat = Cat.new
        render :new
    end

    def create
        @cat = Cat.new(cat_params)
        if @cat.save
            redirect_to cat_url(@cat)
        else
            render json: @cat.errors.full_messages, status: 422
            #unprocessible
        end
    end

    def update
		incoming_wildcard = params(:id)
	    cat = Cat.find_by(incoming_wildcard) # id: params[:id] also works
		if cat && cat.update(cat_params)
			redirect_to cat_id(cat.id)
		else
			render json: cat.errors.full_messages, status: 422 #unprocessable_entity
		end
	end

    def edit
        @cat = Cat.find(params[:id])
        render :edit
        #You can render the form with the cat's data that is already inputted
    end

    private
    def cat_params
        params.require(:cat).permit(:birth_date, :color, :name, :sex, :description)
    end
end
