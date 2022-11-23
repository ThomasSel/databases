require_relative "lib/database_connection"
require_relative "lib/recipe_repository"

DatabaseConnection.connect("recipes_directory")

repo = RecipeRepository.new

recipes = repo.all

recipes.each do |recipe|
  puts "#{recipe.id} - #{recipe.name} - cooking time: #{recipe.avg_cooking_time} - #{recipe.rating}/5"
end