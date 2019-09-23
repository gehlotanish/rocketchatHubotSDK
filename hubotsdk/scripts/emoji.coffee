# Description:
#   emoji.coffee - Replaces :text: or text with emojis.
#   Great for IRC or anywhere not already emojified.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   "put a bird on it" - Prints "put a 🐦  on it" in 'more' emoji mode.
#   "put a :bird: on it" - Prints "put a 🐦  on it" in 'less' emoji mode.
#   hubot list emoji - Print a list of available emojis
#   hubot more emoji - Try to substitute all words - no :colons: required.
#   hubot less emoji - Require :colons: to substitute emojis (default).
#
# Notes:
#   Emoji/unicode pairing data from https://github.com/github/gemoji
#
# Author:
#   dzello

module.exports = (robot) ->

  robot.brain.on "loaded", ->
    robot.brain.data.emojis ?= {}

  robot.hear /.+/, (msg) ->
    if textWithEmoji = substituteEmoji(msg.message.text, robot)
      msg.send(textWithEmoji)

  robot.respond /more emoji/, (msg) ->
    robot.brain.data.emojis.more = true

  robot.respond /less emoji/, (msg) ->
    robot.brain.data.emojis.more = false

  robot.respond /list emoji/, (msg) ->
    buf = ""
    for symbol, hexCode of emojis
      buf += "#{toEmoji(hexCode)}   #{symbol}\n"
    msg.send buf

substituteEmoji = (text, robot) ->
  ct = 0
  re = if robot.brain.data.emojis.more then /([a-zA-Z0-9_:]{3,})/g else /:([a-zA-Z0-9_]+):/g
  text = text.replace re, (match, key) ->
    if emoji = emojis[key.toLowerCase().replace(/:/g, '')]
      ct++
      toEmoji(emoji) + " "
    else
      key
  text if ct > 0

toEmoji = (hexCode) ->
  fromFullCharCode(parseInt(hexCode, 16))

fromFullCharCode = (args...) ->
  chars= []
  for n in args
    if (n < 0x10000)
      chars.push(String.fromCharCode(n));
    else
      high = Math.floor((n - 0x10000) / 0x400) + 0xD800
      low = (n - 0x10000) % 0x400 + 0xDC00
      chars.push(String.fromCharCode(high, low))

  chars.join('')

`emojis = {
  '100': '1f4af',
  '1234': '1f522',
  haircut: '1f487',
  house: '1f3e0',
  ideograph_advantage: '1f250',
  house_with_garden: '1f3e1',
  incoming_envelope: '1f4e8',
  japan: '1f5fe',
  information_source: '2139',
  it: '1f1ee',
  inbox_tray: '1f4e5',
  pisces: '2653',
  loudspeaker: '1f4e2',
  loop: '27bf',
  lips: '1f444',
  libra: '264e',
  leaves: '1f343',
  large_blue_diamond: '1f537',
  man: '1f468',
  laughing: '1f606',
  light_rail: '1f688',
  police_car: '1f693',
  mountain_railway: '1f69e',
  mailbox_closed: '1f4ea',
  musical_note: '1f3b5',
  left_right_arrow: '2194',
  link: '1f517',
  leo: '264c',
  last_quarter_moon_with_face: '1f31c',
  love_hotel: '1f3e9',
  lipstick: '1f484',
  leftwards_arrow_with_hook: '21a9',
  ledger: '1f4d2',
  japanese_goblin: '1f47a',
  left_luggage: '1f6c5',
  japanese_ogre: '1f479',
  information_desk_person: '1f481',
  large_orange_diamond: '1f536',
  koala: '1f428',
  kissing_cat: '1f63d',
  large_blue_circle: '1f535',
  koko: '1f201',
  jp: '1f1ef',
  joy: '1f602',
  last_quarter_moon: '1f317',
  lantern: '1f3ee',
  kr: '1f1f0',
  interrobang: '2049',
  jack_o_lantern: '1f383',
  imp: '1f47f',
  izakaya_lantern: '1f3ee',
  japanese_castle: '1f3ef',
  joy_cat: '1f639',
  key: '1f511',
  kiss: '1f48b',
  kissing_smiling_eyes: '1f619',
  kissing_closed_eyes: '1f61a',
  kimono: '1f458',
  jeans: '1f456',
  icecream: '1f366',
  iphone: '1f4f1',
  kissing: '1f617',
  id: '1f194',
  innocent: '1f607',
  hushed: '1f62f',
  ice_cream: '1f368',
  hourglass_flowing_sand: '23f3',
  hourglass: '231b',
  no_entry: '26d4',
  lock: '1f512',
  memo: '1f4dd',
  muscle: '1f4aa',
  lock_with_ink_pen: '1f50f',
  lemon: '1f34b',
  keycap_ten: '1f51f',
  microphone: '1f3a4',
  no_mobile_phones: '1f4f5',
  mouse2: '1f401',
  kissing_heart: '1f618',
  man_with_gua_pi_mao: '1f472',
  microscope: '1f52c',
  point_down: '1f447',
  pizza: '1f355',
  pouch: '1f45d',
  pound: '1f4b7',
  potable_water: '1f6b0',
  no_mouth: '1f636',
  postbox: '1f4ee',
  poultry_leg: '1f357',
  point_right: '1f449',
  post_office: '1f3e3',
  point_left: '1f448',
  point_up_2: '1f446',
  poodle: '1f429',
  pray: '1f64f',
  no_pedestrians: '1f6b7',
  moyai: '1f5ff',
  point_up: '261d',
  monkey: '1f412',
  postal_horn: '1f4ef',
  no_entry_sign: '1f6ab',
  newspaper: '1f4f0',
  poop: '1f4a9',
  pouting_cat: '1f63e',
  princess: '1f478',
  nine: '0039',
  neutral_face: '1f610',
  no_bell: '1f515',
  ng: '1f196',
  metro: '1f687',
  necktie: '1f454',
  new: '1f195',
  mute: '1f507',
  no_good: '1f645',
  new_moon_with_face: '1f31a',
  nail_care: '1f485',
  low_brightness: '1f505',
  couplekiss: '1f48f',
  copyright: '00a9',
  couple: '1f46b',
  couple_with_heart: '1f491',
  cookie: '1f36a',
  construction: '1f6a7',
  cool: '1f192',
  cherry_blossom: '1f338',
  clock4: '1f553',
  corn: '1f33d',
  credit_card: '1f4b3',
  clock1030: '1f565',
  church: '26ea',
  cop: '1f46e',
  convenience_store: '1f3ea',
  cow: '1f42e',
  clapper: '1f3ac',
  clock1130: '1f566',
  clock12: '1f55b',
  card_index: '1f4c7',
  cat: '1f431',
  bomb: '1f4a3',
  car: '1f697',
  cancer: '264b',
  capricorn: '2651',
  blush: '1f60a',
  candy: '1f36c',
  boom: '1f4a5',
  capital_abcd: '1f520',
  clock930: '1f564',
  bride_with_veil: '1f470',
  book: '1f4d6',
  bookmark_tabs: '1f4d1',
  blue_book: '1f4d8',
  carousel_horse: '1f3a0',
  bust_in_silhouette: '1f464',
  boat: '26f5',
  blowfish: '1f421',
  bookmark: '1f516',
  books: '1f4da',
  black_small_square: '25aa',
  boar: '1f417',
  blue_heart: '1f499',
  boot: '1f462',
  santa: '1f385',
  saxophone: '1f3b7',
  scream: '1f631',
  minidisc: '1f4bd',
  school_satchel: '1f392',
  scorpius: '264f',
  blue_car: '1f699',
  scissors: '2702',
  satisfied: '1f606',
  sandal: '1f461',
  black_square_button: '1f532',
  school: '1f3eb',
  hamster: '1f439',
  satellite: '1f4e1',
  sake: '1f376',
  sa: '1f202',
  busstop: '1f68f',
  sailboat: '26f5',
  running_shirt_with_sash: '1f3bd',
  bulb: '1f4a1',
  sagittarius: '2650',
  mushroom: '1f344',
  massage: '1f486',
  mailbox_with_mail: '1f4ec',
  m: '24c2',
  maple_leaf: '1f341',
  mailbox_with_no_mail: '1f4ed',
  mask: '1f637',
  mega: '1f4e3',
  basketball: '1f3c0',
  arrow_up: '2b06',
  abcd: '1f521',
  '+1': '1f44d',
  alien: '1f47d',
  ant: '1f41c',
  anguished: '1f627',
  sheep: '1f411',
  a: '1f170',
  sos: '1f198',
  '8ball': '1f3b1',
  office: '1f3e2',
  older_man: '1f474',
  seat: '1f4ba',
  smirk_cat: '1f63c',
  tiger: '1f42f',
  vhs: '1f4fc',
  surfer: '1f3c4',
  ok_hand: '1f44c',
  'non-potable_water': '1f6b1',
  older_woman: '1f475',
  ok: '1f197',
  octopus: '1f419',
  mountain_cableway: '1f6a0',
  unlock: '1f513',
  nose: '1f443',
  mount_fuji: '1f5fb',
  notebook_with_decorative_cover: '1f4d4',
  ok_woman: '1f646',
  notes: '1f3b6',
  nut_and_bolt: '1f529',
  ocean: '1f30a',
  o: '2b55',
  new_moon: '1f311',
  mountain_bicyclist: '1f6b5',
  notebook: '1f4d3',
  mag: '1f50d',
  no_bicycles: '1f6b3',
  train2: '1f686',
  smile: '1f604',
  shirt: '1f455',
  speak_no_evil: '1f64a',
  vertical_traffic_light: '1f6a6',
  shit: '1f4a9',
  musical_keyboard: '1f3b9',
  ambulance: '1f691',
  tv: '1f4fa',
  battery: '1f50b',
  lollipop: '1f36d',
  mouse: '1f42d',
  movie_camera: '1f3a5',
  bamboo: '1f38d',
  cold_sweat: '1f630',
  mens: '1f6b9',
  station: '1f689',
  sound: '1f509',
  first_quarter_moon: '1f313',
  elephant: '1f418',
  doughnut: '1f369',
  door: '1f6aa',
  earth_asia: '1f30f',
  fire: '1f525',
  cloud: '2601',
  ear: '1f442',
  eight_pointed_black_star: '2734',
  dizzy: '1f4ab',
  crocodile: '1f40a',
  mailbox: '1f4eb',
  feet: '1f43e',
  heart_eyes: '1f60d',
  currency_exchange: '1f4b1',
  facepunch: '1f44a',
  hankey: '1f4a9',
  minibus: '1f690',
  ferris_wheel: '1f3a1',
  fireworks: '1f386',
  crossed_flags: '1f38c',
  department_store: '1f3ec',
  heavy_check_mark: '2714',
  fountain: '26f2',
  flushed: '1f633',
  fork_and_knife: '1f374',
  waxing_gibbous_moon: '1f314',
  dragon_face: '1f432',
  x: '274c',
  white_circle: '26aa',
  sparkler: '1f387',
  white_medium_small_square: '25fd',
  white_check_mark: '2705',
  uk: '1f1ec',
  v: '270c',
  sunflower: '1f33b',
  white_large_square: '2b1c',
  tent: '26fa',
  triangular_flag_on_post: '1f6a9',
  telephone_receiver: '1f4de',
  tram: '1f68a',
  whale: '1f433',
  triumph: '1f624',
  weary: '1f629',
  hash: '0023',
  speech_balloon: '1f4ac',
  sparkling_heart: '1f496',
  stars: '1f303',
  speaker: '1f50a',
  snowflake: '2744',
  sunglasses: '1f60e',
  speedboat: '1f6a4',
  snake: '1f40d',
  earth_americas: '1f30e',
  smile_cat: '1f638',
  star2: '1f31f',
  small_orange_diamond: '1f538',
  smoking: '1f6ac',
  spaghetti: '1f35d',
  sleepy: '1f62a',
  star: '2b50',
  smiley: '1f603',
  small_red_triangle_down: '1f53b',
  snowman: '26c4',
  small_blue_diamond: '1f539',
  pig: '1f437',
  rice: '1f35a',
  smiley_cat: '1f63a',
  snowboarder: '1f3c2',
  heavy_dollar_sign: '1f4b2',
  smirk: '1f60f',
  rugby_football: '1f3c9',
  smiling_imp: '1f608',
  rowboat: '1f6a3',
  shower: '1f6bf',
  slot_machine: '1f3b0',
  shell: '1f41a',
  hear_no_evil: '1f649',
  pensive: '1f614',
  hibiscus: '1f33a',
  person_frowning: '1f64d',
  raising_hand: '1f64b',
  rabbit2: '1f407',
  snail: '1f40c',
  ramen: '1f35c',
  radio: '1f4fb',
  deciduous_tree: '1f333',
  diamond_shape_with_a_dot_inside: '1f4a0',
  first_quarter_moon_with_face: '1f31b',
  dog: '1f436',
  eggplant: '1f346',
  shoe: '1f45e',
  customs: '1f6c3',
  pill: '1f48a',
  'e-mail': '1f4e7',
  dolphin: '1f42c',
  disappointed_relieved: '1f625',
  dizzy_face: '1f635',
  curly_loop: '27b0',
  crying_cat_face: '1f63f',
  milky_way: '1f30c',
  small_red_triangle: '1f53a',
  coffee: '2615',
  flashlight: '1f526',
  eight_spoked_asterisk: '2733',
  heart_decoration: '1f49f',
  open_mouth: '1f62e',
  curry: '1f35b',
  passport_control: '1f6c2',
  cupid: '1f498',
  high_heel: '1f460',
  heavy_exclamation_mark: '2757',
  gun: '1f52b',
  fries: '1f35f',
  melon: '1f348',
  euro: '1f4b6',
  meat_on_bone: '1f356',
  fish_cake: '1f365',
  gem: '1f48e',
  mahjong: '1f004',
  dog2: '1f415',
  egg: '1f373',
  date: '1f4c5',
  girl: '1f467',
  free: '1f193',
  ear_of_rice: '1f33e',
  full_moon: '1f315',
  man_with_turban: '1f473',
  european_castle: '1f3f0',
  five: '0035',
  fax: '1f4e0',
  crown: '1f451',
  diamonds: '2666',
  fist: '270a',
  cn: '1f1e8',
  flags: '1f38f',
  grin: '1f601',
  exclamation: '2757',
  green_book: '1f4d7',
  fishing_pole_and_fish: '1f3a3',
  cocktail: '1f378',
  factory: '1f3ed',
  frowning: '1f626',
  fr: '1f1eb',
  envelope_with_arrow: '1f4e9',
  handbag: '1f45c',
  foggy: '1f301',
  floppy_disk: '1f4be',
  beer: '1f37a',
  footprints: '1f463',
  globe_with_meridians: '1f310',
  mans_shoe: '1f45e',
  dango: '1f361',
  dancer: '1f483',
  gift_heart: '1f49d',
  dromedary_camel: '1f42a',
  clock330: '1f55e',
  clock3: '1f552',
  construction_worker: '1f477',
  cow2: '1f404',
  email: '2709',
  fast_forward: '23e9',
  file_folder: '1f4c1',
  collision: '1f4a5',
  clock230: '1f55d',
  horse_racing: '1f3c7',
  fish: '1f41f',
  clock2: '1f551',
  confetti_ball: '1f38a',
  heavy_division_sign: '2797',
  u6709: '1f236',
  full_moon_with_face: '1f31d',
  european_post_office: '1f3e4',
  ski: '1f3bf',
  congratulations: '3297',
  football: '1f3c8',
  four_leaf_clover: '1f340',
  negative_squared_cross_mark: '274e',
  confounded: '1f616',
  money_with_wings: '1f4b8',
  honey_pot: '1f36f',
  closed_umbrella: '1f302',
  computer: '1f4bb',
  hearts: '2665',
  dart: '1f3af',
  heart_eyes_cat: '1f63b',
  love_letter: '1f48c',
  racehorse: '1f40e',
  helicopter: '1f681',
  honeybee: '1f41d',
  railway_car: '1f683',
  musical_score: '1f3bc',
  fire_engine: '1f692',
  heavy_multiplication_x: '2716',
  heartpulse: '1f497',
  hotsprings: '2668',
  headphones: '1f3a7',
  family: '1f46a',
  end: '1f51a',
  dragon: '1f409',
  evergreen_tree: '1f332',
  hocho: '1f52a',
  high_brightness: '1f506',
  ship: '1f6a2',
  horse: '1f434',
  see_no_evil: '1f648',
  es: '1f1ea',
  ru: '1f1f7',
  runner: '1f3c3',
  goat: '1f410',
  o2: '1f17e',
  scroll: '1f4dc',
  running: '1f3c3',
  punch: '1f44a',
  secret: '3299',
  question: '2753',
  persevere: '1f623',
  frog: '1f438',
  four: '0034',
  gift: '1f381',
  gemini: '264a',
  dancers: '1f46f',
  relaxed: '263a',
  repeat: '1f501',
  red_circle: '1f534',
  phone: '260e',
  rocket: '1f680',
  purple_heart: '1f49c',
  rose: '1f339',
  fuelpump: '26fd',
  person_with_pouting_face: '1f64e',
  red_car: '1f697',
  rewind: '23ea',
  rice_ball: '1f359',
  disappointed: '1f61e',
  rooster: '1f413',
  restroom: '1f6bb',
  registered: '00ae',
  relieved: '1f60c',
  recycle: '267b',
  rotating_light: '1f6a8',
  rainbow: '1f308',
  rice_cracker: '1f358',
  pear: '1f350',
  ring: '1f48d',
  rat: '1f400',
  eyeglasses: '1f453',
  gb: '1f1ec',
  pencil: '1f4dd',
  fried_shrimp: '1f364',
  revolving_hearts: '1f49e',
  pencil2: '270f',
  partly_sunny: '26c5',
  outbox_tray: '1f4e4',
  page_with_curl: '1f4c3',
  part_alternation_mark: '303d',
  peach: '1f351',
  rice_scene: '1f391',
  roller_coaster: '1f3a2',
  oncoming_police_car: '1f694',
  paperclip: '1f4ce',
  open_file_folder: '1f4c2',
  page_facing_up: '1f4c4',
  paw_prints: '1f43e',
  palm_tree: '1f334',
  ox: '1f402',
  package: '1f4e6',
  one: '0031',
  open_book: '1f4d6',
  oncoming_taxi: '1f696',
  mortar_board: '1f393',
  on: '1f51b',
  ophiuchus: '26ce',
  moneybag: '1f4b0',
  orange_book: '1f4d9',
  open_hands: '1f450',
  mobile_phone_off: '1f4f4',
  monkey_face: '1f435',
  monorail: '1f69d',
  oden: '1f362',
  oncoming_automobile: '1f698',
  cyclone: '1f300',
  panda_face: '1f43c',
  oncoming_bus: '1f68d',
  moon: '1f314',
  fearful: '1f628',
  eyes: '1f440',
  person_with_blond_hair: '1f471',
  leopard: '1f406',
  ram: '1f40f',
  penguin: '1f427',
  repeat_one: '1f502',
  parking: '1f17f',
  pager: '1f4df',
  pig2: '1f416',
  rabbit: '1f430',
  envelope: '2709',
  pig_nose: '1f43d',
  closed_lock_with_key: '1f510',
  ghost: '1f47b',
  confused: '1f615',
  closed_book: '1f4d5',
  clock830: '1f563',
  dollar: '1f4b5',
  ribbon: '1f380',
  clock530: '1f560',
  clock8: '1f557',
  clock430: '1f55f',
  clock11: '1f55a',
  city_sunrise: '1f307',
  clock6: '1f555',
  circus_tent: '1f3aa',
  clock7: '1f556',
  cl: '1f191',
  chocolate_bar: '1f36b',
  clock1: '1f550',
  name_badge: '1f4db',
  clock630: '1f561',
  clock10: '1f559',
  cd: '1f4bf',
  clock9: '1f558',
  clipboard: '1f4cb',
  clock1230: '1f567',
  chart_with_downwards_trend: '1f4c9',
  chart: '1f4b9',
  clock730: '1f562',
  chicken: '1f414',
  performing_arts: '1f3ad',
  city_sunset: '1f306',
  christmas_tree: '1f384',
  cherries: '1f352',
  camel: '1f42b',
  cat2: '1f408',
  cactus: '1f335',
  bug: '1f41b',
  cake: '1f370',
  bullettrain_side: '1f684',
  calendar: '1f4c6',
  checkered_flag: '1f3c1',
  bus: '1f68c',
  broken_heart: '1f494',
  busts_in_silhouette: '1f465',
  bullettrain_front: '1f685',
  chestnut: '1f330',
  calling: '1f4f2',
  bread: '1f35e',
  bridge_at_night: '1f309',
  briefcase: '1f4bc',
  bouquet: '1f490',
  bowling: '1f3b3',
  bow: '1f647',
  droplet: '1f4a7',
  blossom: '1f33c',
  clap: '1f44f',
  clock130: '1f55c',
  cinema: '1f3a6',
  clubs: '2663',
  clock5: '1f554',
  children_crossing: '1f6b8',
  boy: '1f466',
  camera: '1f4f7',
  bento: '1f371',
  black_large_square: '2b1b',
  black_nib: '2712',
  birthday: '1f382',
  black_medium_small_square: '25fe',
  bird: '1f426',
  black_joker: '1f0cf',
  bicyclist: '1f6b4',
  black_circle: '26ab',
  beetle: '1f41e',
  bikini: '1f459',
  no_smoking: '1f6ad',
  bike: '1f6b2',
  black_medium_square: '25fc',
  bell: '1f514',
  mag_right: '1f50e',
  bee: '1f41d',
  bathtub: '1f6c1',
  bar_chart: '1f4ca',
  bath: '1f6c0',
  barber: '1f488',
  baby_symbol: '1f6bc',
  bank: '1f3e6',
  bangbang: '203c',
  arrow_up_small: '1f53c',
  atm: '1f3e7',
  baby: '1f476',
  back: '1f519',
  arrows_clockwise: '1f503',
  b: '1f171',
  arrow_upper_left: '2196',
  balloon: '1f388',
  athletic_shoe: '1f45f',
  arrows_counterclockwise: '1f504',
  ballot_box_with_check: '2611',
  articulated_lorry: '1f69b',
  round_pushpin: '1f4cd',
  radio_button: '1f518',
  raised_hands: '1f64c',
  raised_hand: '270b',
  purse: '1f45b',
  put_litter_in_its_place: '1f6ae',
  rage: '1f621',
  pushpin: '1f4cc',
  pineapple: '1f34d',
  dash: '1f4a8',
  bear: '1f43b',
  baggage_claim: '1f6c4',
  art: '1f3a8',
  arrow_upper_right: '2197',
  chart_with_upwards_trend: '1f4c8',
  baby_chick: '1f424',
  baseball: '26be',
  baby_bottle: '1f37c',
  arrow_forward: '25b6',
  aries: '2648',
  arrow_left: '2b05',
  arrow_lower_left: '2199',
  arrow_right: '27a1',
  ab: '1f18e',
  arrow_down: '2b07',
  anger: '1f4a2',
  accept: '1f251',
  arrow_lower_right: '2198',
  arrow_double_up: '23eb',
  arrow_down_small: '1f53d',
  arrow_heading_up: '2934',
  aquarius: '2652',
  arrow_backward: '25c0',
  abc: '1f524',
  aerial_tramway: '1f6a1',
  astonished: '1f632',
  alarm_clock: '23f0',
  angry: '1f620',
  arrow_right_hook: '21aa',
  arrow_double_down: '23ec',
  arrow_heading_down: '2935',
  apple: '1f34e',
  airplane: '2708',
  angel: '1f47c',
  anchor: '2693',
  '-1': '1f44e',
  zero: '0030',
  yellow_heart: '1f49b',
  zzz: '1f4a4',
  zap: '26a1',
  womens: '1f6ba',
  woman: '1f469',
  wind_chime: '1f390',
  wink: '1f609',
  wave: '1f44b',
  wc: '1f6be',
  white_square_button: '1f533',
  womans_hat: '1f452',
  white_flower: '1f4ae',
  wine_glass: '1f377',
  womans_clothes: '1f45a',
  white_small_square: '25ab',
  worried: '1f61f',
  violin: '1f3bb',
  two_women_holding_hands: '1f46d',
  whale2: '1f40b',
  waning_gibbous_moon: '1f316',
  virgo: '264d',
  tulip: '1f337',
  u5272: '1f239',
  u5408: '1f234',
  watch: '231a',
  wavy_dash: '3030',
  trumpet: '1f3ba',
  two_men_holding_hands: '1f46c',
  two_hearts: '1f495',
  u55b6: '1f23a',
  volcano: '1f30b',
  warning: '26a0',
  video_game: '1f3ae',
  truck: '1f69a',
  tropical_fish: '1f420',
  u6708: '1f237',
  up: '1f199',
  watermelon: '1f349',
  tired_face: '1f62b',
  twisted_rightwards_arrows: '1f500',
  train: '1f683',
  tongue: '1f445',
  water_buffalo: '1f403',
  two: '0032',
  yum: '1f60b',
  turtle: '1f422',
  waning_crescent_moon: '1f318',
  traffic_light: '1f6a5',
  tshirt: '1f455',
  vibration_mode: '1f4f3',
  u6307: '1f22f',
  vs: '1f19a',
  toilet: '1f6bd',
  tokyo_tower: '1f5fc',
  thumbsdown: '1f44e',
  thumbsup: '1f44d',
  tangerine: '1f34a',
  three: '0033',
  ticket: '1f3ab',
  tennis: '1f3be',
  taurus: '2649',
  tm: '2122',
  taxi: '1f695',
  tada: '1f389',
  tea: '1f375',
  telescope: '1f52d',
  symbols: '1f523',
  tanabata_tree: '1f38b',
  syringe: '1f489',
  sunny: '2600',
  suspension_railway: '1f69f',
  sweet_potato: '1f360',
  stuck_out_tongue_closed_eyes: '1f61d',
  sushi: '1f363',
  stew: '1f372',
  sweat_smile: '1f605',
  six_pointed_star: '1f52f',
  space_invader: '1f47e',
  signal_strength: '1f4f6',
  stuck_out_tongue_winking_eye: '1f61c',
  seven: '0037',
  steam_locomotive: '1f682',
  strawberry: '1f353',
  swimmer: '1f3ca',
  skull: '1f480',
  straight_ruler: '1f4cf',
  sunrise: '1f305',
  sweat: '1f613',
  sun_with_face: '1f31e',
  sparkles: '2728',
  statue_of_liberty: '1f5fd',
  sleeping: '1f634',
  soon: '1f51c',
  beginner: '1f530',
  yen: '1f4b4',
  beers: '1f37b',
  white_medium_square: '25fb',
  wolf: '1f43a',
  wrench: '1f527',
  video_camera: '1f4f9',
  walking: '1f6b6',
  waxing_crescent_moon: '1f312',
  wheelchair: '267f',
  tiger2: '1f405',
  sweat_drops: '1f4a6',
  seedling: '1f331',
  wedding: '1f492',
  u7533: '1f238',
  umbrella: '2614',
  sunrise_over_mountains: '1f304',
  us: '1f1fa',
  u7981: '1f232',
  u7a7a: '1f233',
  underage: '1f51e',
  unamused: '1f612',
  u7121: '1f21a',
  sparkle: '2747',
  sob: '1f62d',
  stuck_out_tongue: '1f61b',
  u6e80: '1f235',
  tropical_drink: '1f379',
  trophy: '1f3c6',
  trolleybus: '1f68e',
  triangular_ruler: '1f4d0',
  trident: '1f531',
  top: '1f51d',
  tomato: '1f345',
  telephone: '260e',
  thought_balloon: '1f4ad',
  tophat: '1f3a9',
  tractor: '1f69c',
  soccer: '26bd',
  six: '0036',
  scream_cat: '1f640',
  shaved_ice: '1f367',
  spades: '2660',
  dvd: '1f4c0',
  flower_playing_cards: '1f3b4',
  cry: '1f622',
  hospital: '1f3e5',
  hotel: '1f3e8',
  herb: '1f33f',
  heavy_plus_sign: '2795',
  hatched_chick: '1f425',
  hammer: '1f528',
  grey_exclamation: '2755',
  green_apple: '1f34f',
  grinning: '1f600',
  heavy_minus_sign: '2796',
  hamburger: '1f354',
  guardsman: '1f482',
  hand: '270b',
  green_heart: '1f49a',
  grey_question: '2754',
  golf: '26f3',
  grapes: '1f347',
  heartbeat: '1f493',
  grimacing: '1f62c',
  hatching_chick: '1f423',
  dolls: '1f38e',
  de: '1f1e9',
  do_not_litter: '1f6af',
  dress: '1f457',
  custard: '1f36e',
  eight: '0038',
  earth_africa: '1f30d',
  guitar: '1f3b8',
  game_die: '1f3b2',
  fallen_leaf: '1f342',
  heart: '2764',
  expressionless: '1f611',
  crescent_moon: '1f319',
  electric_plug: '1f50c',
  crystal_ball: '1f52e',
  arrow_up_down: '2195',
  banana: '1f34c'
}`
