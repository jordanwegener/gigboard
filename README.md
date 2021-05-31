# T2A2 - Jordan Wegener - GigBoard

## Identification of the problem you are trying to solve by building this particular marketplace app

After the great disruption to the live music industry that was (and still is) the pandemic, some musicians and venue operators might find it a bit difficult to get back into the swing of things. Some musicians might not know how to market themselves or get themselves out there again, especially if places where they were regulars have closed.

I've created GigBoard to solve this issue - by making it easy for people who need musicians and people who need gigs to play to connect.

## Why is it a problem that needs solving?

The live music industry is among those most hampered by the pandemic. Providing a marketplace where musicians and venue operators can make new connections will help both of those parties to generate income and rebuild the industry.

## A link (URL) to your deployed app (i.e. website)

<https://agile-crag-44883.herokuapp.com/>

## A link to your GitHub repository (repo). Ensure the repo is accessible by your Educators

<https://github.com/jordanwegener/gigboard>

## Description of your marketplace app (website), including

### Purpose

The purpose of GigBoard is to connect musicians seeking work and venue operators who are seeking musicians to provide live music, and provide a platform for the exchange of deposits constituting an agreement to exchange services and money.

### Functionality / features

The core functionality of GigBoard is that it allows users to create gigs and bands, then book gigs as a band.

#### Gigs

Users can list gigs. These contain information about where the gig is, when it is and how much the musician will be paid. Gigs can be searched by their title, location or description.

#### Bands

Users can create bands. These contain information about the band, including a style, description and (if provided by the user) an audio demo which will be shown to the owner of any gig the band requests to book.

#### Booking requests

While viewing a gig, users can request to book that gig using any of the bands they've created. The user can leave a personalised message (perhaps containing a short blurb about the band, or a link to a YouTube video of a performance). When the gig owner views this request they can see this information along with the band's audio demo (if they have one). The gig owner can then accept or reject the request. If accepted, they will be prompted to pay 20% of the ask price they specified as a deposit and to contact the band.

### Sitemap

![sitemap](./docs/sitemap.png)

### Screenshots

![mobile-screenshots-1](./docs/mobile-merged-1.png)

![mobile-screenshots-2](./docs/mobile-merged-2.png)

![index-desktop](./docs/index-desktop.png)

### Target audience

The target audience of this application is those in the live music industry on a local scale. This means bands who play small cafe/pub/bar gigs either professionally or as a side hustle/hobby and owners/operators/managers of cafes/pubs/bars.

### Tech stack (e.g. html, css, deployment platform, etc)

#### Main components

GigBoard is built on Ruby 2.7.2, Rails 6 and PostgreSQL. The front end is written using erb, HTML5, JavaScript and SCSS. Bootstrap is used for default styling and UI components with some custom SCSS.

#### Gems

User authorization, account creation and control is provided by Devise.

Faker is used to generate seed data for testing purposes.

Base64 is used to encode mp3 files and store them as long strings in the database (as an alternative to using Amazon S3 for file storage).

Stripe is used to provide a platform for payment of deposits.

Chronic is used to parse time and date inputs (as provided by humans in various forms) and turn them into Ruby Time objects so they can be formatted nicely before being stored.

#### Deployment

GigBoard is deployed using Heroku, with the Heroku PostgreSQL addon.

## User stories for your app

"As a musician playing bars and clubs professionally, I wish there was a way I could find one-off gigs to play in addition to my usual mainstays so I could make a little more money."

"As someone who is looking to play their first gig, I wish there was somewhere I could find a couple of casual gigs so I could test the waters without too much committment."

"As a bar/club/cafe manager, I wish there was a way to find music on a once-off basis or at late notice without having go through agencies, so that I could simplify the process of finding musicians."

## Wireframes for your app

### Mobile

![mobile1](./docs/mobile-wireframes-1.png)

![mobile2](./docs/mobile-wireframes-2.png)

### Tablet

![tablet](./docs/tablet-wireframes.png)


### Desktop

![index](./docs/desktop-index.png)

![booking](./docs/desktop-newgig.png)

## An ERD for your app

![erd](./docs/ERD.png)

## Explain the different high-level components (abstractions) in your app

### Users, Authentication, Authorisation

User accounts and authentication are provided by the Devise gem. Devise provies helper functions such as `current_user` which allow the application to determine whether there is a logged in user and who that user is. Depending on whether a Devise user session currently exists and the identity of the user, different parts of the views are served to the user. This allows limited functionality in case the user is not logged in, or if the user does not own the object they are trying to manage (e.g. a gig or band).

### Search

A search functionality on the index page is provided using an ILIKE query, allowing case-insensitive search of the gigs table for title, location and description. Case-insensitive search is important as it greatly increases the likelihood of a user finding what they're looking for - case-sensitive search will discard many results due to capitalised first letters in sentences, ect.

### Audio Upload and Playback

The creation and editing of gig listings and bands are similar, using `form_with` for the forms and employing input sanitisation in their respective controllers. The new band form, however, also supports image upload to allow bands to provide a demo that will be showed to the owners of gigs that they request to book. In lieu of Amazon S3 or similar, I opted to use Base64 to encode mp3 files and store them, with a header appended, as text in the database. These files are then read directly from the database into a HTML5 audio player. While this decreases reliance on external sources, it does have drawbacks: no buffering is possible and the entire file must be loaded before playing. I have implemented a file size limit of 10MB to prevent very long page load times.

### Time Input Formatting

The `date`, `start_time` and `end_time` for gigs are parsed by Chronic which is able to parse a wide variety of different time-like text inputs (even with typos) and turn them into Ruby Time objects. These time objects are then parsed again by `strftime` with options to produce uniform and easily readable information which is only then inserted into the database.

### Negotiations and Payment

The negotiation process begins with a user who has a band selecting a gig and sending a booking request for that gig. The user chooses which band to send the booking request as and can send a message to the gig owner. The gig owner can then view the pending negotiation (called a 'booking' in the front end since it's a term users will be more familiar with) and accept or reject. If rejected, the status of the gig becomes 'rejected'. The negotiation still appears for both users until they opt to remove it, so that they are able to see that it was declined before it vanishes (which would likely lead to user confusion). If accepted, the status is set to 'accepted' and the gig owner is prompted to pay 20% of the ask price as a deposit. This is intended to be held by GigBoard until the gig has been completed, when it will be released to the band.

## Detail any third party services that your app will use

At this time, GigBoard does not use any third party APIs. In future it will be updated to use a geospatial API to allow location selection from a map and filtering of gigs by location or proximity to the user's location.

GigBoard does use Stripe for payment. This allows the app to redirect the user to Stripe's front end to facilitate the payment of deposits to bands. The page the user interacts with is external to the application.

## Describe your projects models in terms of the relationships (active record associations) they have with each other

A user `has_many` gigs.

A user `has_many` bands.

A gig `belongs_to` one user.

A band `belongs_to` one  user.

A gig `has_many` negotiations.

A band `has_many` negotiations.

A negotiation `belongs_to` one gig and `belongs_to` one band.

Dependencies are set up so that deleting a user deletes all gigs, bands and negotiations which relate to that user.

```ruby
class User < ApplicationRecord
  has_many :bands, dependent: :destroy
  has_many :gigs, dependent: :destroy
end

class Gig < ApplicationRecord
  belongs_to :user
  has_many :negotiations, dependent: :destroy
end

class Band < ApplicationRecord
  belongs_to :user
  has_many :negotiations, dependent: :destroy
end

class Negotiation < ApplicationRecord
  belongs_to :gig
  belongs_to :band
end
```

## Discuss the database relations to be implemented in your application

The User model does not have any foreign keys. The Gig model has one foreign key, a user_id which relates it to a single instance of User (one user to many gigs). The Band model also has one foreign key, a user_id relating it to a single instance of User (also one user to many bands). The Negotiation model has two foreign keys - one band_id and one gig_id. Each Negotiation belongs to a single Band and a single Gig (one band to many  negotiations, one gig to many negotiations).

## Provide your database schema design

```ruby
ActiveRecord::Schema.define(version: 2021_05_29_144931) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bands", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.text "style"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.text "demo"
    t.index ["user_id"], name: "index_bands_on_user_id"
  end

  create_table "gigs", force: :cascade do |t|
    t.string "title"
    t.string "location"
    t.string "start_time"
    t.string "end_time"
    t.decimal "ask_price"
    t.boolean "active"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "date"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_gigs_on_user_id"
  end

  create_table "negotiations", force: :cascade do |t|
    t.decimal "ask_price"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "band_id", null: false
    t.bigint "gig_id", null: false
    t.text "message"
    t.integer "status"
    t.boolean "active_band"
    t.index ["band_id"], name: "index_negotiations_on_band_id"
    t.index ["gig_id"], name: "index_negotiations_on_gig_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "negotiations", "bands"
  add_foreign_key "negotiations", "gigs"
end
```

## Describe the way tasks are allocated and tracked in your project

Trello is used for project management. Tasks were sorted into the categories 'Setup', 'Back end', 'Front end' and 'Documentation'. These categories were populated with tasks to do. During execution, tasks were moved into a 'Done' category as they were completed.

The Trello board is located at <https://trello.com/b/SaSvBNZp/gigboard-t2a2>