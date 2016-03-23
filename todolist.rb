class TodoList
  attr_accessor :title
  attr_reader :todos

  def initialize(title)
    @title = title
    @todos = []
  end

  def add(todo)
    if todo.instance_of? Todo
      todos << todo
    else
      raise TypeError, 'can only add Todo objects'
    end
  end

  def size
    todos.size
  end

  def first
    todos.first
  end

  def last
    todos.last
  end

  def item_at(index)
    todos.fetch(index)
  end

  def mark_done_at(index)
    item_at(index).done!
  end

  def mark_undone_at(index)
    item_at(index).undone!
  end

  def shift
    todos.shift
  end

  def pop
    todos.pop
  end

  def remove_at(index)
    todos.delete_at(index)
  end

  def to_s
    puts "---- #{title} ----"
    todos.each { |todo| puts todo }
  end

  def each
    counter = 0
    loop do
      break if counter == size
      yield(item_at(counter))
      counter += 1
    end
    self
  end

  def select
    selected = TodoList.new(title)
    each do |todo|
      selected.add(todo) if yield(todo)
    end
    selected
  end

  def find_by_title(search)
    select { |todo| todo.title == search }.first
  end

  def all_done
    select(&:done?)
  end

  def all_not_done
    select { |todo| !todo.done? }
  end

  def mark_done(search)
    find_by_title && find_by_title(search).done!
  end

  def mark_all_done
    each(&:done!)
  end

  def mark_all_undone
    each(&:undone!)
  end
end


class TypeError < StandardError
  def message
    "Can only add Todo objects"
  end
end


class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end
end





# todo1 = Todo.new("Buy milk")
# todo2 = Todo.new("Clean room")
# todo3 = Todo.new("Go to gym")
# list = TodoList.new("Today's Todos")

# # ---- Adding to the list -----


# list.add(todo1)                 # adds todo1 to end of list, returns list
# list.add(todo2)                 # adds todo2 to end of list, returns list
# list.add(todo3)                 # adds todo3 to end of list, returns list
# # p list.add(1)   


# list.size                       # returns 3

# # first
# list.first                      # returns todo1, which is the first item in the list

# # last
# list.last 

# # list.item_at                    # raises ArgumentError
# list.item_at(1)                 # returns 2nd item in list (zero based index)
# # p list.item_at(100)               # raises IndexError

# # ---- Marking items in the list -----

# # mark_done_at
# # list.mark_done_at               # raises ArgumentError
# list.mark_done_at(1)            # marks the 2nd item as done
# # list.mark_done_at(100)          # raises IndexError

# # mark_undone_at
# # list.mark_undone_at             # raises ArgumentError
# # list.mark_undone_at(1)          # marks the 2nd item as not done,
# # list.mark_undone_at(100)        # raises IndexError

# # ---- Deleting from the the list -----

# # shift
# # list.shift                      # removes and returns the first item in list

# # pop
# # list.pop                        # removes and returns the last item in list

# # remove_at
# # list.remove_at                  # raises ArgumentError
# # list.remove_at(1)               # removes and returns the 2nd item
# # list.remove_at(100)             # raises IndexError

# # ---- Outputting the list -----

# # to_s
# # list.to_s


