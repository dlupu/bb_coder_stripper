require 'spec_helper'
describe BbCodesStriper do
  describe "strip_bb_code(value, tag)" do

    it {
      value = "[b:1njw686r]on peut capter TF1 sur chaine 251[/b:1njw686r]"
      BbCodesStriper.strip_bb_code(value, :b).should == "on peut capter TF1 sur chaine 251"
    }

    it {
      value = "[b:1njw686r]]on peut capter TF1 sur chaine 251[/b:1njw686r]"
      BbCodesStriper.strip_bb_code(value, :b).should == "]on peut capter TF1 sur chaine 251"
    }

    it {
      value = "[b:1njw686r]on peut capter TF1 sur chaine 251[[/b:1njw686r]"
      BbCodesStriper.strip_bb_code(value, :b).should == "on peut capter TF1 sur chaine 251["
    }

    it {
      value = "[b]on peut capter TF1 sur chaine 251[/b]"
      BbCodesStriper.strip_bb_code(value, :b).should == "on peut capter TF1 sur chaine 251"
    }

    it {
      value = "[B]on peut capter TF1 sur chaine 251[/B]"
      BbCodesStriper.strip_bb_code(value, :b).should == "on peut capter TF1 sur chaine 251"
    }


    it {
      value = "[quote=&quot;didilou76&quot;:a0xiki53]xxx[/quote:a0xiki53]"
      BbCodesStriper.strip_bb_code(value, :quote).should == "xxx"
    }

    it {
      value = "[quote=&quot;didilou76&quot;:a0xiki53]xxx[/quote:a0xiki53]"
      BbCodesStriper.strip_bb_code(value, :quote).should == "xxx"
    }

    it {
      value = "[quote=&quot;dark vador&quot;:a0xiki53]xxx[/quote:a0xiki53]"
      BbCodesStriper.strip_bb_code(value, :quote).should == "xxx"
    }

    it {
      value = "[quote=&quot;the real dark vador&quot;:a0xiki53]xxx[/quote:a0xiki53]"
      BbCodesStriper.strip_bb_code(value, :quote).should == "xxx"
    }

    it {
      value = "[url=http&#58;//droit-finances&#46;commentcamarche&#46;net/forum/affich-3908783-probleme-resiliation-tps-canal-apres-2ar:4ptv1rim]Voir la[/url:4ptv1rim]"
      BbCodesStriper.strip_bb_code(value, :url).should == "Voir la"
    }

    it {
      value = "[url:1r5vewha]http&#58;//media&#46;canal-plus&#46;com/file/15/2/124152&#46;pdf[/url:1r5vewha]"
      BbCodesStriper.strip_bb_code(value, :url).should == "http&#58;//media&#46;canal-plus&#46;com/file/15/2/124152&#46;pdf"
    }

  end


  describe "strip_smileys(value)" do

    it {
      smiley = '<!-- s:mrgreen: --><img src="{SMILIES_PATH}/icon_mrgreen.gif" alt=":mrgreen:" title="Mr. Green" /><!-- s:mrgreen: -->'
      BbCodesStriper.strip_smileys(smiley).should == ':mrgreen:'
    }

    it {
      smiley = '<!-- s:mrgreen: --><IMG src="{SMILIES_PATH}/icon_mrgreen.gif" alt=":mrgreen:" title="Mr. Green" /><!-- s:mrgreen: -->'
      BbCodesStriper.strip_smileys(smiley).should == ':mrgreen:'
    }


    it {
      smiley = '<!-- s:D --><img src="{SMILIES_PATH}/icon_e_biggrin.gif" alt=":D" title="Very Happy" /><!-- s:D -->'
      BbCodesStriper.strip_smileys(smiley).should == ':D'
    }


    it {
      smiley = '<!-- s:mrgreen: --><img src="{SMILIES_PATH}/icon_mrgreen.gif" alt=":mrgreen:" title="Mr. Green" /><!-- s:mrgreen: --> <!-- s:D --><img src="{SMILIES_PATH}/icon_e_biggrin.gif" alt=":D" title="Very Happy" /><!-- s:D -->'
      BbCodesStriper.strip_smileys(smiley).should == ':mrgreen: :D'
    }


    it {
      smiley = '<!-- s:mrgreen: --><img src="{SMILIES_PATH}/icon_mrgreen.gif" alt=":mrgreen:" title="Mr. Green" /><!-- s:mrgreen: --> miau <!-- s:D --><img src="{SMILIES_PATH}/icon_e_biggrin.gif" alt=":D" title="Very Happy" /><!-- s:D -->'
      BbCodesStriper.strip_smileys(smiley).should == ':mrgreen: miau :D'
    }

  end

  describe "delete_bb_code(value, tag)" do
    it {
      value = "A[b:1njw686r]B[/b:1njw686r]C"
      BbCodesStriper.delete_bb_code(value, :b).should == "AC"
    }

    it {
      value = "A[b]B[/b]C"
      BbCodesStriper.delete_bb_code(value, :b).should == "AC"
    }

    it {
      value = "A[b][x]B[/x][/b]C"
      BbCodesStriper.delete_bb_code(value, :b).should == "AC"
    }

    it {
      value = "A[B]B[/B]C"
      BbCodesStriper.delete_bb_code(value, :b).should == "AC"
    }

    it {
      value = "A[b]B[/b]C[b]D[/b]E"
      BbCodesStriper.delete_bb_code(value, :b).should == "ACE"
    }

    it {
      value = "A[b][x]B[/x][/b]C[b][x]D[/x][/b]E"
      BbCodesStriper.delete_bb_code(value, :b).should == "ACE"
    }

    it {
      value = "[img:1mdzeyo6]http&#58;//images&#46;forum-auto&#46;com/mesimages/384504/poubelle&#46;jpg[/img:1mdzeyo6]"
      BbCodesStriper.delete_bb_code(value, :img).should == ""
    }

    it {
      value = "[attachment=0:2rpk2ymv]<!-- ia0 -->P1000054.jpg<!-- ia0 -->[/attachment:2rpk2ymv]"
      BbCodesStriper.delete_bb_code(value, :attachment).should == ""
    }



  end


  describe "strip links" do
    it {
      value = "<a href=#>test</a>"
      BbCodesStriper.strip_links(value).should == "test"
    }
  end

end