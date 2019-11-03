class Ancestry_seeds

  class Create_keys
    def initialize(base)
      hash_key = []
      @results = []
      base.each do |data|
        hash_key << data["id"]
      end
      keys = hash_key.uniq
      keys.each do |key|
        arry = []
        base.each do |data|
          if data["id"] == key
            arry << {category:"#{data['name']}"}
          end
        end
        result = "#{key}.children.create(#{arry})\n"
        @results << result
      end
    end
    def results
      @results
    end
  end

  def initialize
    require 'csv'
    base_data = CSV.read('./db/category/base.csv', headers: true)
    sub_data = CSV.read('./db/category/sub.csv', headers: true)
    appliance_data = CSV.read('./db/category/appliance.csv', headers: true) #P8
    babykids_data = CSV.read('./db/category/babykids.csv', headers: true) #P3
    bookmusicgame_data = CSV.read('./db/category/bookmusicgame.csv', headers: true) #P5
    carbike_data = CSV.read('./db/category/carbike.csv', headers: true) #P12
    cosme_data = CSV.read('./db/category/cosme.csv', headers: true) #P7
    handmade_data = CSV.read('./db/category/handmade.csv', headers: true) #P10
    interior_data = CSV.read('./db/category/interior.csv', headers: true) #P4
    ladies_data = CSV.read('./db/category/ladies.csv', headers: true) #P1
    mens_data = CSV.read('./db/category/mens.csv', headers: true) #P2
    other_data = CSV.read('./db/category/other.csv', headers: true) #P13
    sports_data = CSV.read('./db/category/sports.csv', headers: true) #P9
    ticket_data = CSV.read('./db/category/ticket.csv', headers: true) #P11
    toys_data = CSV.read('./db/category/toys.csv', headers: true) #P6

    shioya_p = []
    base_data.each do |data|
      first_msg = "P#{data["id"]} = Category.create(:category=>'#{data["category"]}')\n"
      shioya_p << first_msg
    end

    shioya_c = []
    sub_data.each do |data|
      second_msg = %Q[P#{data["pid"]}_C#{data["id"]} = P#{data["pid"]}.children.create(:category=>"#{data["subcategory"]}")\n]
      shioya_c << second_msg
    end

    p1 = Create_keys.new(ladies_data)
    p2 = Create_keys.new(mens_data)
    p3 = Create_keys.new(babykids_data)
    p4 = Create_keys.new(interior_data)
    p5 = Create_keys.new(bookmusicgame_data)
    p6 = Create_keys.new(toys_data)
    p7 = Create_keys.new(cosme_data)
    p8 = Create_keys.new(appliance_data)
    p9 = Create_keys.new(sports_data)
    p10 = Create_keys.new(handmade_data)
    p11 = Create_keys.new(ticket_data)
    p12 = Create_keys.new(carbike_data)
    p13 = Create_keys.new(other_data)

    shioya_gc = []
    shioya_gc << p1.results
    shioya_gc << p2.results
    shioya_gc << p3.results
    shioya_gc << p4.results
    shioya_gc << p5.results
    shioya_gc << p6.results
    shioya_gc << p7.results
    shioya_gc << p8.results
    shioya_gc << p9.results
    shioya_gc << p10.results
    shioya_gc << p11.results
    shioya_gc << p12.results
    shioya_gc << p13.results
    shioya_gc.flatten!

    File.open("./db/created.rb", mode = "w"){|f|
      shioya_p.each do |parent|
        f.write(parent)
      end
      shioya_c.each do |child|
        f.write(child)
      end
      shioya_gc.each do |granchild|
        f.write(granchild)
      end
    }
  end
end