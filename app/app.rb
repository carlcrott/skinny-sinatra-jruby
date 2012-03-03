require 'java'
require 'sinatra'
require File.expand_path('oscar4-all-4.1-with-dependencies.jar', File.dirname(__FILE__))

# http://wbear.wordpress.com/2010/03/20/sinatra-request-headers-helper/
helpers do
  def request_headers
    env.inject({}){|acc, (k,v)| acc[$1.downcase] = v if k =~ /^http_(.*)/i; acc}
  end
end


get '/' do
  "Hello Hackers    3!!"
end

get '/headers' do
  "TEH HOST EZZZ #{request_headers['host']}"
end

get '/parse' do
  # Implement "respond_to" >> http://www.sinatrarb.com/contrib/respond_with.html

  def oscarizer(process)
    include_class "uk.ac.cam.ch.wwmm.oscar.chemnamedict.entities.ChemicalStructure"
    include_class "uk.ac.cam.ch.wwmm.oscar.chemnamedict.entities.FormatType"
    include_class "uk.ac.cam.ch.wwmm.oscar.chemnamedict.entities.ResolvedNamedEntity"
    include_class "uk.ac.cam.ch.wwmm.oscar.Oscar"

    oscar = Oscar.new
    output_process = []
    entities = oscar.findAndResolveNamedEntities(process)

    for ne in entities
      puts ne.getSurface()
      output_process << ne.getSurface()

      inchi = ne.getFirstChemicalStructure(FormatType::INCHI)
      if inchi != nil 
        puts inchi
        output_process << inchi
      end
    end
    return output_process.join("\n")
  end

  input = request_headers['process']

  "#{ oscarizer(input.to_s) } \n"
end


get '/parse_test' do
  def oscarizer
    include_class "uk.ac.cam.ch.wwmm.oscar.chemnamedict.entities.ChemicalStructure"
    include_class "uk.ac.cam.ch.wwmm.oscar.chemnamedict.entities.FormatType"
    include_class "uk.ac.cam.ch.wwmm.oscar.chemnamedict.entities.ResolvedNamedEntity"
    include_class "uk.ac.cam.ch.wwmm.oscar.Oscar"

    tester = "To a solution of 3-bromobenzophenone (1.00 g, 4 mmol) in MeOH (15 mL) was added sodium borohydride (0.3 mL, 8 mmol) portionwise at rt and the suspension was stirred at rt for 1-24 h. The reaction was diluted slowly with water and extracted with CH2Cl2. The organic layer was washed successively with water, brine, dried over Na2SO4, and concentrated to give the title compound as oil (0.8 g, 79%), which was used in the next reaction without further purification. MS (ESI, pos. ion) m/z: 247.1 (M-OH)."

    oscar = Oscar.new
    output_process = []
    entities = oscar.findAndResolveNamedEntities(tester)

    for ne in entities
      puts ne.getSurface()
      output_process << ne.getSurface()

      inchi = ne.getFirstChemicalStructure(FormatType::INCHI)
      if inchi != nil 
        puts inchi
        output_process << inchi
      end
    end
    return output_process.join("<br />")
  end

  "#{oscarizer}"
end




