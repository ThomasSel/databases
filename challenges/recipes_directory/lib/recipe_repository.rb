require_relative "database_connection"
require_relative "recipe"

class RecipeRepository

  # Selecting all records
  def all
    sql_query = "SELECT id, name, avg_cooking_time, rating FROM recipes;"
    query_result = DatabaseConnection.exec_params(sql_query, [])
    return make_recipes(query_result)
  end

  # Gets a single record by its ID
  def find(id)
    sql_query = "SELECT id, name, avg_cooking_time, rating FROM recipes WHERE id = $1;"
    query_result = DatabaseConnection.exec_params(sql_query, [id])
    return make_recipes(query_result).first
  end

  private

  def make_recipes(query_result)
    recipes = []
    query_result.each do |record|
      recipe = Recipe.new
      recipe.id = record["id"]
      recipe.name = record["name"]
      recipe.avg_cooking_time = record["avg_cooking_time"]
      recipe.rating = record["rating"]
      recipes << recipe
    end

    return recipes
  end
end