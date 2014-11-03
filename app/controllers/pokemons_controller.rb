class PokemonsController < ApplicationController
    def capture
        @pokemon = Pokemon.find(params[:id])
        @pokemon.trainer_id = current_trainer.id
        @pokemon.save
        redirect_to root_path # this is the same as '/'
    end

    def damage
        @pokemon = Pokemon.find(params[:id])
        @pokemon.health = @pokemon.health - 10
        @pokemon.save
        if (@pokemon.health <= 0)
            Pokemon.where(:id => @pokemon.id).destroy_all
        end
        trainer = Trainer.find(@pokemon.trainer_id)
        redirect_to trainer_path(trainer)
    end

    def new
        @pokemon = Pokemon.new
    end

    def create
        @pokemon = Pokemon.new(pokemon_params)
        @pokemon.level = 1
        @pokemon.health = 100
        @pokemon.trainer_id = current_trainer.id
        if (@pokemon.save)
            redirect_to trainer_path(current_trainer.id)
        else
            flash[:error] = @pokemon.errors.full_messages.to_sentence
            render 'new'
        end
    end

    def pokemon_params
        params.require(:pokemon).permit(:name)
    end
end
