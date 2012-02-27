require 'rubygems'
require 'bundler'
require 'pathname'
require 'java'


Bundler.require

require 'sinatra'




get '/' do
  "Hello Hackers!!"
end


get '/parse' do
  def oscarizer
    this_dir = Pathname.new(File.dirname(__FILE__))

    # specify individual .jars used in this project
    class_paths = [
      "commons-lang-2.1.jar",
      "oscar4-all-4.1-with-dependencies.jar"
    ]

    for class_path in class_paths
      jar_path = (this_dir + class_path)
      $CLASSPATH << jar_path
    end

    include_class "uk.ac.cam.ch.wwmm.oscar.chemnamedict.entities.ChemicalStructure"
    include_class "uk.ac.cam.ch.wwmm.oscar.chemnamedict.entities.FormatType"
    include_class "uk.ac.cam.ch.wwmm.oscar.chemnamedict.entities.ResolvedNamedEntity"
    include_class "uk.ac.cam.ch.wwmm.oscar.Oscar"

    tester = "To a solution of 3-bromobenzophenone (1.00 g, 4 mmol) in MeOH (15 mL) was added sodium borohydride (0.3 mL, 8 mmol) portionwise at rt and the suspension was stirred at rt for 1-24 h. The reaction was diluted slowly with water and extracted with CH2Cl2. The organic layer was washed successively with water, brine, dried over Na2SO4, and concentrated to give the title compound as oil (0.8 g, 79%), which was used in the next reaction without further purification. MS (ESI, pos. ion) m/z: 247.1 (M-OH)."

    oscar = Oscar.new

    entities = oscar.findAndResolveNamedEntities(tester)

    for ne in entities
      puts ne.getSurface()
      inchi = ne.getFirstChemicalStructure(FormatType::INCHI)
      inchi != nil ? (puts inchi) : ""
    end

  end

  


  "#{oscarizer}"
  

end




