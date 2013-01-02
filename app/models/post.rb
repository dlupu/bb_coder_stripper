class Post < ActiveRecord::Base

  self.table_name = "phpbb_posts"
  self.primary_key = "post_id"


  def self.sanitize_bb
    nb = 0
    Post.find_in_batches do |group|

        puts '*'
        group.each do  |model|

          model.post_text = BbCodesStriper.sanitize_bb(model.post_text)

         if model.changed?
           puts "----------"
           puts model.changes
           puts "----------"

           model.save

           nb += 1
         end


        end
       puts ''
    end

    puts "updated #{nb} posts"


  end


end