# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


CATEGORIES = [
  {name: 'Restaurante', name_plural: 'Restaurantes'},
  {name: 'Café', name_plural: 'Cafés' },
  {name: 'Museu', name_plural: 'Museus' },
  {name: 'Zoo', name_plural: 'Zoos' },
  {name: 'Cabeleireiro', name_plural: 'Cabeleireiros' },
  {name: 'Teatro', name_plural: 'Teatros' },
  {name: 'Cinema', name_plural: 'Cinemas' }
]

puts 'Seeding categories...'
CATEGORIES.each do |c|
  Category.create!(c)
end


LOCATIONS = {
  'Aveiro' => [
    'Águeda',
    'Albergaria-a-Velha',
    'Anadia',
    'Arouca',
    'Aveiro',
    'Castelo de Paiva',
    'Espinho',
    'Estarreja',
    'Ílhavo',
    'Mealhada',
    'Murtosa',
    'Oliveira de Azeméis',
    'Oliveira do Bairro',
    'Ovar',
    'Santa Maria da Feira',
    'São João da Madeira',
    'Sever do Vouga',
    'Vagos',
    'Vale de Cambra'
  ],
  'Beja' => [
    'Aljustrel',
    'Almodôvar',
    'Alvito',
    'Barrancos',
    'Beja',
    'Castro Verde',
    'Cuba',
    'Ferreira do Alentejo',
    'Mértola',
    'Moura',
    'Odemira',
    'Ourique',
    'Serpa',
    'Vidigueira'
  ],
  'Braga' => [
    'Amares',
    'Barcelos',
    'Braga',
    'Cabeceiras de Basto',
    'Celorico de Basto',
    'Esposende',
    'Fafe',
    'Guimarães',
    'Póvoa de Lanhoso',
    'Terras de Bouro',
    'Vieira do Minho',
    'Vila Nova de Famalicão',
    'Vila Verde',
    'Vizela'
  ],
  'Bragança' => [
    'Alfândega da Fé',
    'Bragança',
    'Carrazeda de Ansiães',
    'Freixo de Espada à Cinta',
    'Macedo de Cavaleiros',
    'Miranda do Douro',
    'Mirandela',
    'Mogadouro',
    'Torre de Moncorvo',
    'Vila Flor',
    'Vimioso',
    'Vinhais'
  ],
  'Castelo Branco' => [
    'Belmonte',
    'Castelo Branco',
    'Covilhã',
    'Fundão',
    'Idanha-a-Nova',
    'Oleiros',
    'Penamacor',
    'Proença-a-Nova',
    'Sertã',
    'Vila de Rei',
    'Vila Velha de Ródão'
  ],
  'Coimbra' => [
    'Arganil',
    'Cantanhede',
    'Coimbra',
    'Condeixa-a-Nova',
    'Figueira da Foz',
    'Góis',
    'Lousã',
    'Mira',
    'Miranda do Corvo',
    'Montemor-o-Velho',
    'Oliveira do Hospital',
    'Pampilhosa da Serra',
    'Penacova',
    'Penela',
    'Soure',
    'Tábua',
    'Vila Nova de Poiares'
  ],
  'Évora' => [
    'Alandroal',
    'Arraiolos',
    'Borba',
    'Estremoz',
    'Évora',
    'Montemor-o-Novo',
    'Mora',
    'Mourão',
    'Portel',
    'Redondo',
    'Reguengos de Monsaraz',
    'Vendas Novas',
    'Viana do Alentejo',
    'Vila Viçosa'
  ],
  'Faro' => [
    'Albufeira',
    'Alcoutim',
    'Aljezur',
    'Castro Marim',
    'Faro',
    'Lagoa',
    'Lagos',
    'Loulé',
    'Monchique',
    'Olhão',
    'Portimão',
    'São Brás de Alportel',
    'Silves',
    'Tavira',
    'Vila do Bispo',
    'Vila Real de Santo António'
  ],
  'Guarda' => [
    'Aguiar da Beira',
    'Almeida',
    'Celorico da Beira',
    'Figueira de Castelo Rodrigo',
    'Fornos de Algodres',
    'Gouveia',
    'Guarda',
    'Manteigas',
    'Mêda',
    'Pinhel',
    'Sabugal',
    'Seia',
    'Trancoso',
    'Vila Nova de Foz Côa'
  ],
  'Leiria' => [
    'Alcobaça',
    'Alvaiázere',
    'Ansião',
    'Batalha',
    'Bombarral',
    'Caldas da Rainha',
    'Castanheira de Pera',
    'Figueiró dos Vinhos',
    'Leiria',
    'Marinha Grande',
    'Nazaré',
    'Óbidos',
    'Pedrógão Grande',
    'Peniche',
    'Pombal',
    'Porto de Mós'
  ],
  'Lisboa' => [
    'Alenquer',
    'Arruda dos Vinhos',
    'Azambuja',
    'Cadaval',
    'Lourinhã',
    'Sobral de Monte Agraço',
    'Torres Vedras'
  ],
  'Portalegre' => [
    'Alter do Chão',
    'Arronches',
    'Avis',
    'Campo Maior',
    'Castelo de Vide',
    'Crato',
    'Elvas',
    'Fronteira',
    'Gavião',
    'Marvão',
    'Monforte',
    'Nisa',
    'Ponte de Sor',
    'Portalegre',
    'Sousel'
  ],
  'Porto' => [
    'Amarante',
    'Baião',
    'Felgueiras',
    'Lousada',
    'Marco de Canaveses',
    'Paços de Ferreira',
    'Penafiel'
  ],
  'Santarém' => [
    'Abrantes',
    'Alcanena',
    'Almeirim',
    'Alpiarça',
    'Benavente',
    'Cartaxo',
    'Chamusca',
    'Constância',
    'Coruche',
    'Entroncamento',
    'Ferreira do Zêzere',
    'Golegã',
    'Mação',
    'Ourém',
    'Rio Maior',
    'Salvaterra de Magos',
    'Santarém',
    'Sardoal',
    'Tomar',
    'Torres Novas',
    'Vila Nova da Barquinha'
  ],
  'Setúbal' => [
    'Alcácer do Sal',
    'Alcochete',
    'Almada',
    'Barreiro',
    'Grândola',
    'Moita',
    'Montijo',
    'Palmela',
    'Santiago do Cacém',
    'Seixal',
    'Sesimbra',
    'Setúbal',
    'Sines'
  ],
  'Viana do Castelo' => [
    'Arcos de Valdevez',
    'Caminha',
    'Melgaço',
    'Monção',
    'Paredes de Coura',
    'Ponte da Barca',
    'Ponte de Lima',
    'Valença',
    'Viana do Castelo',
    'Vila Nova de Cerveira'
  ],
  'Vila Real' => [
    'Alijó',
    'Boticas',
    'Chaves',
    'Mesão Frio',
    'Mondim de Basto',
    'Montalegre',
    'Murça',
    'Peso da Régua',
    'Ribeira de Pena',
    'Sabrosa',
    'Santa Marta de Penaguião',
    'Valpaços',
    'Vila Pouca de Aguiar',
    'Vila Real'
  ],
  'Viseu' => [
    'Armamar',
    'Carregal do Sal',
    'Castro Daire',
    'Cinfães',
    'Lamego',
    'Mangualde',
    'Moimenta da Beira',
    'Mortágua',
    'Nelas',
    'Oliveira de Frades',
    'Penalva do Castelo',
    'Penedono',
    'Resende',
    'Santa Comba Dão',
    'São João da Pesqueira',
    'São Pedro do Sul',
    'Sátão',
    'Sernancelhe',
    'Tabuaço',
    'Tarouca',
    'Tondela',
    'Vila Nova de Paiva',
    'Viseu',
    'Vouzela'
  ],
  'Açores' => [
    'Corvo',
    'Faial',
    'Flores',
    'Graciosa',
    'Pico',
    'Santa Maria',
    'São Jorge',
    'São Miguel',
    'Terceira'
  ],
  'Madeira' => [
    'Madeira',
    'Porto Santo'
  ]
}

puts 'Seeding locations...'

Location.create(district: 'Lisboa',
                area: 'Grande Lisboa',
                aliases: [
                  'Amadora', 'Cascais', 'Lisboa',
                  'Loures', 'Mafra', 'Odivelas',
                  'Oeiras', 'Sintra',
                  'Vila Franca de Xira'
                ])

Location.create(district: 'Porto',
                area: 'Grande Porto',
                aliases: [
                  'Gondomar', 'Maia', 'Matosinhos',
                  'Paredes', 'Porto', 'Póvoa de Varzim',
                  'Santo Tirso', 'Trofa',
                  'Valongo', 'Vila do Conde',
                  'Vila Nova de Gaia'
                ])

LOCATIONS.each do |district, areas|
  areas.each do |name|
    Location.create!(district: district, area: name)
  end
end