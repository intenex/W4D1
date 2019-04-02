class ArtworksController < ApplicationController
    def index
        if params[:user_id]
            user = User.find_by(id: params[:user_id]) # because this is nested, it automatically prefixes the id with user_id instead of just id to specify
            all_artworks = Hash.new
            all_artworks[:created_artworks] = user.artworks
            all_artworks[:shared_artworks] = user.shared_artworks
            render json: all_artworks
        else
            artworks = Artwork.all
            render json: artworks 
        end
    end

    def create
        artwork = Artwork.new(artwork_params)
        if artwork.save
          render json: artwork
        else
          render json: artwork.errors.full_messages, status: :unprocessable_entity
        end
    end

    def show
        artwork = Artwork.find_by(id: params[:id])
        render json: artwork
    end

    def update
        artwork = Artwork.find_by(id: params[:id])
        if params[:artwork]
            if artwork.update(artwork_params)
                render json: artwork
            else
                render json: artwork.errors.full_messages, status: :unprocessable_entity
            end
        end
    end

    def destroy
        artwork = Artwork.find_by(id: params[:id])

        if artwork.destroy
            redirect_to artworks_url
        else
            render json: artwork.errors.full_messages, status: :unprocessable_entity
        end
    end

    private

    def artwork_params
        params.require(:artwork).permit(:title, :image_url, :artist_id)
    end
end
