class Api::OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update, :destroy]

  # GET /orders
  def order
    @current_pos = get_current_possition(params[:commands])
    if @current_pos
      @last_pos = @current_pos

      params[:commands].drop(1).each do |cmd|
        send(cmd.downcase)
      end

      if @last_pos.save!
        render json: return_output(@last_pos)
      else
        render json: return_output(@last_pos.errors)
      end
    else
      render json: {error: "Please run seed file"}
    end
  end



  private

    
    def north
      @last_pos.facing = "NORTH"
    end

    def south
      @last_pos.facing = "SOUTH"
    end

    def east
      @last_pos.facing = "EAST"
    end

    def west
      @last_pos.facing = "WEST"
    end

    def left
      case @last_pos.facing
      when "NORTH"
        @last_pos.facing = "WEST"
      when "SOUTH"
        @last_pos.facing = "EAST"
      when "EAST"
        @last_pos.facing = "NORTH"
      when "WEST"
        @last_pos.facing = "SOUTH"
      end
    end

    def right
      case @last_pos.facing
      when "NORTH"
        @last_pos.facing = "EAST" 
      when "SOUTH"
        @last_pos.facing = "WEST"
      when "EAST"
        @last_pos.facing = "SOUTH"
      when "WEST"
        @last_pos.facing = "NORTH"
      end
    end

    def move
      case @last_pos.facing
      when "NORTH"
        @last_pos.y_pos += 1
      when "SOUTH"
        @last_pos.y_pos -= 1
      when "EAST"
        @last_pos.x_pos += 1
      when "WEST"
        @last_pos.x_pos -= 1
      end      
    end

    def report      
    end

    def return_output(order)
      {
        location: [order.x_pos,order.y_pos, order.facing]
      }      
    end

    def get_current_possition(order_params)
      Order.new(x_pos: get_x_pos(order_params[0]), 
                y_pos: get_y_pos(order_params[0]), 
                facing: get_fecing(order_params[0])
              )
    end

    def get_x_pos(arr)
      arr.split("PLACE")[1].split(",")[0].to_i
    end

    def get_y_pos(arr)
      arr.split("PLACE")[1].split(",")[1].to_i
    end

    def get_fecing(arr)
      arr.split("PLACE")[1].split(",")[2]
    end
end
