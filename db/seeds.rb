# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  email: 'admin@gmail.com',
  password: 'password'
)

Genre.create!(
  name: 'クッキー'
)

Genre.create!(
  name: 'プリン'
)

Genre.create!(
  name: 'ドリンク'
)

Item.create!(
  genre_id: 1,
  item_name: 'バタークッキー',
  description: 'おすすめです',
  image: open('./app/assets/images/cookie.jpg'),
  non_taxed_price: 130
)

Item.create!(
  genre_id: 1,
  item_name: 'チョコレートクッキー',
  description: '大好評です',
  image: open('./app/assets/images/chocolate_cookies.jpeg'),
  non_taxed_price: 140
)

Item.create!(
  genre_id: 2,
  item_name: 'マスタードプリン',
  description: '人気です',
  image: open('./app/assets/images/puding.jpg'),
  non_taxed_price: 150
)

Item.create!(
  genre_id: 2,
  item_name: 'ココアプリン',
  description: 'リピート率No.1商品',
  image: open('./app/assets/images/cocoa_puding.jpg'),
  non_taxed_price: 160
)

Item.create!(
  genre_id: 3,
  item_name: 'ソーダ',
  description: '期間限定商品です',
  image: open('./app/assets/images/soda.jpg'),
  non_taxed_price: 170
)

Item.create!(
  genre_id: 3,
  item_name: 'オレンジジュース',
  description: '果汁100％です',
  image: open('./app/assets/images/orange_juice.jpg'),
  non_taxed_price: 180
)

EndUser.create!(
  email: 'satotaro@gmail.com',
  password: 'ssssss',
  last_name: '佐藤',
  first_name: '太郎',
  last_name_kana: 'サトウ',
  first_name_kana: 'タロウ',
  postal_code: '150-0001',
  address: '東京都渋谷区神宮前6-20-10',
  phone_number: '070-1111-2222'
)

EndUser.create!(
  email: 'tanakajiro@gmail.com',
  password: 'tttttt',
  last_name: '田中',
  first_name: '二郎',
  last_name_kana: 'タナカ',
  first_name_kana: 'ジロウ',
  postal_code: '231-0002',
  address: '神奈川県横浜市中区海岸通1-1-4',
  phone_number: '080-3333-4444'
)

EndUser.create!(
  email: 'yamadasaburo@gmail.com',
  password: 'yyyyyy',
  last_name: '山田',
  first_name: '三郎',
  last_name_kana: 'ヤマダ',
  first_name_kana: 'サブロウ',
  postal_code: '273-8530',
  address: '千葉県船橋市浜町2-1-1',
  phone_number: '090-5555-6666'
)

EndUser.create!(
  email: 'nakamurashiro@gmail.com',
  password: 'nnnnnn',
  last_name: '中村',
  first_name: '四郎',
  last_name_kana: 'ナカムラ',
  first_name_kana: 'シロウ',
  postal_code: '357-0001',
  address: '埼玉県飯能市宮沢327-6',
  phone_number: '070-7777-8888',
  is_deleted: true
)

EndUser.create!(
  email: 'itogoro@gmail.com',
  password: 'iiiiii',
  last_name: '伊藤',
  first_name: '五郎',
  last_name_kana: 'イトウ',
  first_name_kana: 'ゴロウ',
  postal_code: '415-0023',
  address: '静岡県下田市3-22-31',
  phone_number: '080-9999-0000'
)

EndUser.create!(
  email: 'kimurarokuro@gmail.com',
  password: 'kkkkkk',
  last_name: '木村',
  first_name: '六郎',
  last_name_kana: 'キムラ',
  first_name_kana: 'ロクロウ',
  postal_code: '403-0017',
  address: '山梨県富士吉田市新西原5-6-1',
  phone_number: '090-1234-5678'
)

Address.create!(
  end_user_id: 1,
  name: '佐藤家(貸別荘)',
  postal_code: '384-0703',
  address: '長野県南佐久郡佐久穂町千代里2093-15'
)

Address.create!(
  end_user_id: 2,
  name: '田中家(貸別荘)',
  postal_code: '399-9422',
  address: '長野県北安曇郡小谷村千国乙12860-1'
)

Address.create!(
  end_user_id: 3,
  name: '山田家(貸別荘)',
  postal_code: '386-2204',
  address: '長野県上田市菅平高原1223-3433'
)