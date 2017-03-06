uire 'rails_helper'

describe "beerlist page" do

  before :all do
    self.use_transactional_fixtures = false
    WebMock.disable_net_connect!(allow_localhost:true)
  end

  before :each do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start

    @brewery1 = FactoryGirl.create(:brewery, name: "Koff")
    @brewery2 = FactoryGirl.create(:brewery, name: "Schlenkerla")
    @brewery3 = FactoryGirl.create(:brewery, name: "Ayinger")
    @style1 = Style.create name: "Lager"
    @style2 = Style.create name: "Rauchbier"
    @style3 = Style.create name: "Weizen"
    @beer1 = FactoryGirl.create(:beer, name: "Nikolai", brewery: @brewery1, style: @style1)
    @beer2 = FactoryGirl.create(:beer, name: "Fastenbier", brewery: @brewery2, style: @style2)
    @beer3 = FactoryGirl.create(:beer, name: "Lechte Weisse", brewery: @brewery3, style: @style3)
  end

  after :each do
    DatabaseCleaner.clean
  end

  after :all do
    self.use_transactional_fixtures = true
  end

    it "shows a known beer", :js => true do
    visit beerlist_path
    find('table').find('tr:nth-child(2)')
    save_and_open_page
    expect(page).to have_content "Nikolai"
  end

  it "shows beers in order by name", :js => true do
    click_link "name"
    visit beerlist_path

    find('table').find('tr:nth-child(2)')
    save_and_open_page
    expect(page).to have_content "Fastenbier"

    find('table').find('tr:nth-child(3)')
    save_and_open_page
    expect(page).to have_content "Lechte Weisse"

    find('table').find('tr:nth-child(4)')
    save_and_open_page
    expect(page).to have_content "Nikolai"
  end

  it "shows beers in order by style", :js => true do
    visit beerlist_path
    click_link "style"

    find('table').find('tr:nth-child(2)')
    save_and_open_page
    expect(page).to have_content "Nikolai"
    
    find('table').find('tr:nth-child(3)')
    save_and_open_page
    expect(page).to have_content "Fastenbier"

    find('table').find('tr:nth-child(4)')
    save_and_open_page
    expect(page).to have_content "Lechte Weisse"
  end 

   it "shows beers in order by brewery", :js => true do
    visit beerlist_path
    click_link "brewery"

    find('table').find('tr:nth-child(2)')
    save_and_open_page
    expect(page).to have_content "Lechte Weisse"
    
    find('table').find('tr:nth-child(3)')
    save_and_open_page
    expect(page).to have_content "Nikolai"

    find('table').find('tr:nth-child(4)')
    save_and_open_page
    expect(page).to have_content "Fastenbier"
  end 


end