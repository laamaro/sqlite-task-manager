class Task
  attr_reader :id
  attr_accessor :title, :description

  def initialize(attributes = {})
    @id = attributes[:id]
    @description = attributes[:description]
    @title = attributes[:title]
    @done = attributes[:done] || false
  end

  def done?
    @done
  end

  def done!
    @done = true
  end

  def self.find(id)
    query = "SELECT * FROM tasks WHERE id=?"

    task = DB.execute(query, id).first

    task ? Task.new(id: task['id'], description: task['description'], title: task['title']) : nil
  end

  # SAVE
  def save
    @id ? update : create
  end

  # CREATE
  def create
    query = "INSERT INTO tasks (description, title, done) VALUES (?,?,?)"

    DB.execute(query, @description, @title, @done ? 1 : 0)
    @id = DB.last_insert_row_id
  end

  # UPDATE
  def update
    query = "UPDATE tasks SET description = ?, title = ?, done = ? WHERE id = ?"

    DB.execute(query, @description, @title, @done ? 1 : 0, @id)
  end

  # DELETE
  def destroy
    query = "DELETE FROM tasks WHERE id = ?"

    DB.execute(query, id)
  end

  # ALL
  def self.all
    query = "SELECT * FROM tasks"

    results = DB.execute(query)

    tasks = []

    results.each do |task|
      tasks << Task.new(id: task['id'], description: task['description'], title: task['title'], done: task['done'] == 1)
    end
    tasks
  end
end
