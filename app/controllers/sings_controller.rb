class SingsController < ApplicationController

  def index
    @sings = Sing.order("RANDOM()").all
    @arthist_flg = "1"
  end

end
