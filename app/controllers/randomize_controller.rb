class RandomizeController < ApplicationController
    def randomize
        @clothes = Clothe.all

    end
end
