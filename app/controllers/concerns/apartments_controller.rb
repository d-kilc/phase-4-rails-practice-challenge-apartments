class ApartmentsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :not_found
rescue_from ActiveRecord::RecordInvalid, with: :not_valid
    def index
        apartments = Apartment.all
        render json: apartments, status: 200
    end

    def create
        apartment = Apartment.create! apartments_params
        render json: apartment, status: 201 
    end

    def show
        apartment = find_apartment params[:id]
        render json: apartment, status: 200
    end

    def update
        apartment = find_apartment params[:id]
        apartment.update! apartments_params
        render json: apartment, status: 200
    end

    def destroy
        apartment = find_apartment params[:id]
        apartment.destroy!
        render json: {}, status: 204
    end

    private 

    def apartments_params
        params.permit :number
    end

    def not_valid invalid
        render json: {error: invalid.record.errors}, status: 400
    end

    def not_found
        render json: {error: "Record not found"}, status: 404
    end

    def find_apartment id
        id = params[:id]
        apartment = Apartment.find id
    end
end
