require_relative('../db/sql_runner')
require_relative('./item') 

class Manufacturer
  attr_reader :id
  attr_accessor :name, :sector

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @sector = options['sector']
  end

  def save()
    sql = "INSERT INTO manufacturers (name, sector) VALUES ($1, $2) RETURNING id"
    values = [@name, @sector]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def update()
    sql = "UPDATE manufacturers SET (name, sector) = ($1, $2) WHERE id = $3"
    values = [@name, @sector, @id]
    results = SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM manufacturers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  # Shop keepers should be able to assign manufacturers to stock items.
  def products()
    sql = "SELECT * FROM items WHERE manuf_id = $1"
    values = [@id]
    items = SqlRunner.run(sql, values)
    return items.map{|item| Item.new(item)}
  end

  def self.find(id)
    sql = "SELECT * FROM manufacturers WHERE id = $1"
    values = [id]
    manuf_object = SqlRunner.run(sql, values)
    result = Manufacturer.new(manuf_object.first)
    return result
  end

  def self.all()
    sql = "SELECT * FROM manufacturers"
    manufs = SqlRunner.run(sql)
    result = manufs.map { |manuf_object| Manufacturer.new(manuf_object)}
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM manufacturers"
    result = SqlRunner.run(sql)
  end

end
