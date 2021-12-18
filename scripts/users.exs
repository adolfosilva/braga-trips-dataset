Mix.install([{:jason, "~> 1.2"}, {:faker, "~> 0.17"}])

defmodule Generator do
  def user do
    %{
       name: "#{Faker.Person.first_name()} #{Faker.Person.last_name()}",
       email: Faker.Internet.free_email(),
       password: :base64.encode(:crypto.strong_rand_bytes(12))
     }
  end
end

users = Enum.map(0..10, fn _ -> Generator.user() end)
json = Jason.encode!(users)
IO.puts(json)

File.write!("users.json", json)
