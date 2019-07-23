
require 'pry'
class Pokemon
    attr_accessor :name, :id, :type, :db, :hp
    def initialize (props={})
        @id = props[:id]
        @name = props[:name]
        @type = props[:type]
        @hp = props[:hp]
    end

    def self.save (name, type, db)
        sql  = "INSERT INTO pokemon (name, type) VALUES (\"#{name}\", \"#{type}\")" 
        db.execute(sql)
    end

    def self.find(id, db)
        
        sql = <<-SQL
                SELECT *
                FROM pokemon
                WHERE id = #{id}
                SQL
        x = db.execute(sql)[0]
        Pokemon.new(name: x[1], id: x[0], type: x[2], hp: x[3])  
    end

    def alter_hp (new_hp, db)
        db.execute("UPDATE pokemon SET hp = ? WHERE id = ?", new_hp, self.id)

    end
end
