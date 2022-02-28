class TenantsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :not_found
rescue_from ActiveRecord::RecordInvalid, with: :not_valid
    def index
        tenants = Tenant.all
        render json: tenants, status: 200
    end

    def create
        tenant = Tenant.create! tenants_params
        render json: tenant, status: 201 
    end

    def show
        tenant = find_tenant params[:id]
        render json: tenant, status: 200
    end

    def update
        tenant = find_tenant params[:id]
        tenant.update! tenants_params
        render json: tenant, status: 200
    end

    def destroy
        tenant = find_tenant params[:id]
        tenant.destroy!
        render json: {}, status: 204
    end

    private 

    def tenants_params
        params.permit :name,:age
    end

    def not_valid invalid
        render json: {error: invalid.record.errors}, status: 400
    end

    def not_found
        render json: {error: "Record not found"}, status: 404
    end

    def find_tenant id
        id = params[:id]
        tenant = Tenant.find id
    end
end
