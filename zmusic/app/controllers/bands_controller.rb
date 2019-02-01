class BandsController < ApplicationController
    def def index
      @bands = Band.all
      render :index
    end
    # def new
    #     render :new
    # end

    # def create

    # end
end