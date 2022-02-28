class LeasesController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :not_found
rescue_from ActiveRecord::RecordInvalid, with: :not_valid
    
    def index
        render json: Lease.all, status: 200
    end

    def create
        lease = Lease.create! leases_params
        render json: Lease.all, status: 200
    end

    def destroy
        lease = Lease.find params[:id]
        lease.destroy!
        render json: {}, status: 200
    end

    private

    def leases_params
        params.permit :rent, :tenant_id, :apartment_id
    end

    def not_valid invalid
        render json: invalid.record.errors, status: 400
    end

    def not_found
        render json: {error: "Record not found"}, status: 404
    end
end
