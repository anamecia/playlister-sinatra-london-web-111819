class Slugifiable

    def self.slug(name)
        name.gsub(" ","-")
    end 

    def self.unslug(name)
        name.gsub("-"," ")
    end 
end 