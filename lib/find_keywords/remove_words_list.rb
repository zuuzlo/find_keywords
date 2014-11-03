module FindKeywords
  STOP_WORDS = [
    'a','cannot','into','our','thus','about','co','is','ours','to','above',
    'could','it','ourselves','together','across','down','its','out','too',
    'after','during','itself','over','toward','afterwards','each','last','own',
    'towards','again','eg','latter','per','under','against','either','latterly',
    'perhaps','until','all','else','least','rather','up','almost','elsewhere',
    'less','same','upon','alone','enough','ltd','seem','us','along','etc',
    'many','seemed','very','already','even','may','seeming','via','also','ever',
    'me','seems','was','although','every','meanwhile','several','we','always',
    'everyone','might','she','well','among','everything','more','should','were',
    'amongst','everywhere','moreover','since','what','an','except','most','so',
    'whatever','and','few','mostly','some','when','another','first','much',
    'somehow','whence','any','for','must','someone','whenever','anyhow',
    'former','my','something','where','anyone','formerly','myself','sometime',
    'whereafter','anything','from','namely','sometimes','whereas','anywhere',
    'further','neither','somewhere','whereby','are','had','never','still',
    'wherein','around','has','nevertheless','such','whereupon','as','have',
    'next','than','wherever','at','he','no','that','whether','be','hence',
    'nobody','the','whither','became','her','none','their','which','because',
    'here','noone','them','while','become','hereafter','nor','themselves','who',
    'becomes','hereby','not','then','whoever','becoming','herein','nothing',
    'thence','whole','been','hereupon','now','there','whom','before','hers',
    'nowhere','thereafter','whose','beforehand','herself','of','thereby','why',
    'behind','him','off','therefore','will','being','himself','often','therein',
    'with','below','his','on','thereupon','within','beside','how','once',
    'these','without','besides','however','one','they','would','between','i',
    'only','this','yet','beyond','ie','onto','those','you','both','if','or',
    'though','your','but','in','other','through','yours','by','inc','others',
    'throughout','yourself','can','indeed','otherwise','thru','yourselves'
    ]

  MARKET_WORDS = [ 'select','styles','shop','reg','orig','set', 'sets', 'offer',
      'valid','get','free','shipping','double','december','coupon','save','ends',
      'january','affiliate','exclusive','buy','use','code','size','order','use',
      'checkout','expires','purchase','just','plus','sales','tax','promo','holiday',
      'delivery','ca','co','ma','mi','oh','ri','online','members','back','points',
      'orders'
    ]
  
  class RemoveWordsList

    attr_reader :word_list

    @@instance_collector = []

    def initialize (word_list)
      if word_list.is_a?(String)
        @word_list = word_list.split(" ")
      elsif word_list.is_a?(Array)
        @word_list = word_list
      elsif word_list.is_a?(Hash)
        @word_list = word_list.collect { |k, v| "#{k} #{v} " }.join.split(" ")
      else
        @word_list = []
      end
      @@instance_collector << self
    end

    def self.all
      all_custom + stop_words
    end

    def self.all_custom
      all_words = []
      @@instance_collector.each do | words |
        words.word_list.each do | word |
          all_words << word
        end
      end
      all_words
    end

    def self.stop_words
      STOP_WORDS + MARKET_WORDS
    end
  end
end
