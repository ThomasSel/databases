require "recipe_repository"
require "pg"

def reset_recipes_table
  seed_sql = File.read('spec/seeds_recipes.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test' })
  connection.exec(seed_sql)
end

describe RecipeRepository do
  before(:each) do 
    reset_recipes_table
  end

  it "all returns an array of the records as Recipe instances" do
    DatabaseConnection
    
    repo = RecipeRepository.new
    recipes = repo.all

    expect(recipes.length).to eq 3

    expect(recipes.first.id).to eq "1"
    expect(recipes.first.name).to eq "Pasta"
    expect(recipes.first.avg_cooking_time).to eq "15"
    expect(recipes.first.rating).to eq "4"
  end

  it "find(2) returns the recipe with id 2" do
    repo = RecipeRepository.new
    recipe = repo.find(2)

    expect(recipe.id).to eq "2"
    expect(recipe.name).to eq "Risotto"
    expect(recipe.avg_cooking_time).to eq "45"
    expect(recipe.rating).to eq "5"
  end
end