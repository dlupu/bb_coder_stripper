class BbCodesStriper
  include ActionView::Helpers::SanitizeHelper


  def self.strip_bb_code(value, tag)
     #value.gsub(/\[(\/?)#{tag}((([^\s\]]*)(\s*))*)\]/i, "")     #too slow
     value.gsub(/\[(\/?)#{tag}((([^\s\]]*)(\s*)){,5})\]/i, "")
  end


  def self.delete_bb_code(value,tag)
    value.gsub(/\[#{tag}([^\s\]]*)\]((?!\[\/#{tag}).)*\[\/#{tag}([^\s\]]*)\]/i, "")
  end

  #smileys appear like this : <!-- s:? --><img src="{SMILIES_PATH}/icon_e_confused.gif" alt=":?" title="Confused" /><!-- s:? -->
  #the regexp can handle multiple consecutive smilesy
  #will return the smiley ( ":?"  in this case )

  def self.strip_smileys(value)
    smiley_regexp = /<!--\s*s(\S{2,10})\s*-->\s*<img([^>]*)\/>\s*<!--\s*s(\S{2,10})\s*-->/i


    #first strip the smileys
    value.gsub(smiley_regexp){
      $1
    }
  end

  def self.strip_links(html)
      self.new.strip_links(html)
  end
  
  
  def self.sanitize_bb(value)
     result = value

     result = BbCodesStriper.strip_smileys(result)  # be sure to start with the smileys

     result = BbCodesStriper.strip_links(result)  # be sure to start with the smileys

     result = BbCodesStriper.strip_bb_code(result, :url)
     result = BbCodesStriper.strip_bb_code(result, :b)
     result = BbCodesStriper.strip_bb_code(result, :size)
     result = BbCodesStriper.strip_bb_code(result, :color)
     result = BbCodesStriper.strip_bb_code(result, :u)
     result = BbCodesStriper.strip_bb_code(result, :i)

     result = BbCodesStriper.delete_bb_code(result, :attachment)
     result = BbCodesStriper.delete_bb_code(result, :img)

    return result
  end
end