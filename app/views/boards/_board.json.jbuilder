json.extract! board, :id, :name, :email, :width, :height, :grid, :created_at, :updated_at
json.url board_url(board, format: :json)
