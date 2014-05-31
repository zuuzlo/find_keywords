require "find_keywords/version"

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

  class Keywords

    attr_accessor :sentence

    def initialize (sentence)
      if sentence.is_a?(String)
        @sentence = sentence
      elsif sentence.is_a?(Array)
        @sentence = sentence.join(' ')
      elsif sentence.is_a?(Hash)
        @sentence = sentence.collect { |k, v| "#{k} #{v} " }.join
      else
        @sentence = ''
      end 
    end

    def keywords
      slug = @sentence
      slug.gsub! /['`]/,""
      slug.gsub! /\s*@\s*/, " at "
      slug.gsub! /\s*&\s*/, " and "
      slug.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, ' '
      #slug.gsub! /\ \d+/, ''
      slug.gsub!(/[^a-zA-Z ]/,'')
      slug.gsub!(/ +/,' ')
      #convert double underscores to single
      #slug.gsub! /_+/,"_"
      #strip off leading/trailing underscore
      #slug.gsub! /\A[_\.]+|[_\.]+\z/,""  
      words = slug.downcase.scan(/\w+/)
      slug_words = words.select { |word| !STOP_WORDS.include?(word)}
      slug_words = slug_words.select { |word| !MARKET_WORDS.include?(word)}
      slug = slug_words.join(' ')
      keywords = slug.scan(/\w+/)
      keywords.delete_if { |word| word.size <= 2 }
      keywords.uniq! if keywords.uniq
      return keywords
    end
  end
end
