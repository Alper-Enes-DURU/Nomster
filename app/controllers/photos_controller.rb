class PhotosController < ApplicationController
  before_action :authenticate_user!
  
    def create
      @place = Place.find(params[:place_id])
      # Handle case when @place.user != current_user
      @place.photos.create(photo_params.merge(user: current_user))

      redirect_to place_path(@place)
    end 

    def destroy
      @photo = Photo.find(params[:id])

      if @photo.user != current_user
        return render plain: 'Not Allowed', status: :forbidden
      end

      @photo.destroy
      redirect_to root_path
    end

    private
  
    def photo_params
      params.require(:photo).permit(:caption, :picture)
    end
    
end
