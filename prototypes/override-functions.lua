-- require "prototypes.override-functions"

function RemoveFromRecipe(Name, Ingredient)
	for k, v in pairs(data.raw["recipe"][Name].ingredients) do
		if v[1] == Ingredient or v.name == Ingredient then 
			table.remove(data.raw["recipe"][Name].ingredients, k) 
		end
	end
end

function AddToRecipe(Name, Ingredient, Amount)
	table.insert(data.raw["recipe"][Name].ingredients,{Ingredient, Amount})
end

function ChangeRecipe(Name, Ingredient1, Ingredient2, Amount)
	for k, v in pairs(data.raw["recipe"][Name].ingredients) do
		if v[1] == Ingredient1 then table.remove(data.raw["recipe"][Name].ingredients, k) end
	end
table.insert(data.raw["recipe"][Name].ingredients,{Ingredient2, Amount})
end

function AddRecipeToTech(Name, Recipe)
	table.insert(data.raw["technology"][Name].effects,{type = "unlock-recipe",recipe = Recipe})
end

function AddRequirementToTech(Name, Requirement)
	table.insert(data.raw["technology"][Name].prerequisites, Requirement)
end

function Add_To_Recipe_Looped(Data)
	for bla,name in pairs(Data.Ingredient) do
		table.insert(data.raw["recipe"][Data.Name].ingredients,name)
	end
end

function Add_Requirement_To_Tech_Looped(Data)
	for bla,name in pairs(Data.Prereq) do
		table.insert(data.raw["technology"][Data.Name].prerequisites, name)
	end
end

function Add_Recipe_To_Tech_Looped(Data)
	for bla,name in pairs(Data.Recipes) do
	table.insert(data.raw["technology"][Data.Name].effects,{type = "unlock-recipe",recipe = name})
	end
end

function AddIngredientToTech(Name, Ingredient, Amount)
	table.insert(data.raw["technology"][Name].unit.ingredients,{Ingredient, Amount})
end

function Add_Ingredient_To_Tech_Smart(Data)
	local Statement1 = Data.Ingredients.Science1
	local Statement2 = Data.Ingredients.Science2
	local Statement3 = Data.Ingredients.Science3
	local Statement4 = Data.Ingredients.Science4
	if Statement1 then
		table.insert(data.raw["technology"][Data.Name].unit.ingredients,{"science-pack-1", 1})
	end
	if Statement2 then
		table.insert(data.raw["technology"][Data.Name].unit.ingredients,{"science-pack-2", 1})
	end
	if Statement3 then
		table.insert(data.raw["technology"][Data.Name].unit.ingredients,{"science-pack-3", 1})
	end
	if Statement4 then
		table.insert(data.raw["technology"][Data.Name].unit.ingredients,{"alien-science-pack", 1})
	end
end


------------------------------------- Rounding function for fluids to item conversation ------------------------------------------------

function round(num, idp)
  local mult = 10^(idp or 0)
  return math.ceil(num * mult + 0.5) / mult
end

---------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------

function ReplaceAllIngredientFluidWithFluid(Fluid1 , Fluid2)
	for i, recipe in pairs(data.raw.recipe) do
		for v, ingredient in pairs(data.raw.recipe[recipe.name].ingredients) do
			if ingredient.type == "fluid" then
				if ingredient.name == Fluid1 then
					ingredient.type = "fluid"
					ingredient.name = Fluid2
					-- ingredient.amount = ingredient.amount
				end
			end
		end
	end
end	
------------------------------------------------------------------------------------

-- function ReplaceAllIngredientItemWithFluid(Item , Fluid)
	-- for i, recipe in pairs(data.raw.recipe) do
		-- for v, ingredient in pairs(data.raw.recipe[recipe.name].ingredients) do
			-- if ingredient.type == "item" then
				-- if ingredient.name == Item then
					-- ingredient.type = "fluid"
					-- ingredient.name = Fluid
					-- ingredient.amount = round(ingredient.amount * 1)
					-- data.raw.recipe[recipe.name].category = "crafting-with-fluid"
				-- end
			-- end
		-- end
	-- end
-- end	


function ReplaceAllIngredientItemWithItem(Item1 , Item2)
	for i, recipe in pairs(data.raw["recipe"]) do
		for v, ingredient in pairs(data.raw["recipe"][recipe.name].ingredients) do
			if ingredient.name == Item1 then
				RemoveFromRecipe(recipe.name,Item1)
				AddToRecipe(recipe.name, Item2, ingredient.amount)
			elseif ingredient[1] == Item1 then
				RemoveFromRecipe(recipe.name,Item1)
				AddToRecipe(recipe.name, Item2, ingredient[2])
			end
		end
	end
end	




-- function ChangeRecipeFluid(Name, Ingredient1, Ingredient2, Amount)
	-- for k, v in pairs(data.raw["recipe"][Name].ingredients) do
		-- if v[1] == Ingredient1 then table.remove(data.raw["recipe"][Name].ingredients, k) end
	-- end
-- data.raw.recipe[Name].category = "crafting-with-fluid"
-- table.insert(data.raw["recipe"][Name].ingredients,{name= Ingredient2, type= "fluid", amount=  Amount})
-- end

-- function ReplaceAllIngredientItemWithFluid(Item , Fluid)
	-- for i, recipe in pairs(data.raw.recipe) do
		-- for v, ingredient in pairs(data.raw.recipe[recipe.name].ingredients) do
				-- if ingredient.name == Item then
					-- ChangeRecipeFluid(recipe.name, Item1 , Fluid , ingredient.amount)
				-- end

		-- end
	-- end
-- end	

-- ---------------------------------------------------------------------------------------

-- function ReplaceAllIngredientItemWithItem(Before , After)
	-- for i, recipe in pairs(data.raw.recipe) do
		-- for v, ingredient in pairs(data.raw.recipe[recipe.name].ingredients) do
			-- if ingredient.name == Before then
				-- ChangeRecipe(recipe.name, Before, After, ingredient.amount)
			-- end
		-- end
	-- end
-- end	
