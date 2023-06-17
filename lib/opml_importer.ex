defmodule OPMLImporter do
  @moduledoc """
  Simple script to import an OPML file into an account.
  """

  @type feed_outline() :: %{
          required(:type) => String.t(),
          required(:url) => String.t(),
          optional(:title) => String.t()
        }

  @spec main(String.t(), String.t(), String.t()) :: :ok
  def main(opml_file_url, username \\ "yt", password \\ "opmlimporter") do
    {:ok, account} = create_account_if_not_exists(username, password)
    opml_file_path = "priv/#{System.os_time()}.opml"

    clear_current_sources_from_account(account)
    download_file(opml_file_url, opml_file_path)

    OPMLClient.run(opml_file_path)
    |> import_opml()
    |> add_sources_to_account(account)

    pretty_print_added_feeds(account)
  end

  @spec clear_current_sources_from_account(UnLib.Account.t()) :: :ok
  defp clear_current_sources_from_account(account) do
    account
    |> UnLib.Sources.list()
    |> Enum.each(&UnLib.Sources.remove(&1, account))

    :ok
  end

  @spec create_account_if_not_exists(String.t(), String.t()) :: {:ok, UnLib.Account.t()}
  defp create_account_if_not_exists(username, password) do
    case UnLib.Accounts.get_by_username(username) do
      {:error, :not_found} -> UnLib.Accounts.create(username, password)
      user -> user
    end
  end

  @spec download_file(String.t(), String.t()) :: :ok
  defp download_file(remote_url, local_path) do
    System.cmd("wget", [remote_url, "-O", local_path])
    :ok
  end

  @spec import_opml(term()) :: [UnLib.Source.t()]
  defp import_opml(parsed_opml) do
    case Enum.at(parsed_opml, 0) do
      %{children: _feeds} -> import_categories(parsed_opml)
      _ -> import_feeds(parsed_opml)
    end
  end

  @spec import_categories([map()]) :: [UnLib.Source.t()]
  defp import_categories(categories) do
    Enum.flat_map(categories, &import_feeds(&1.children))
  end

  @spec import_feeds([map()]) :: [UnLib.Source.t()]
  defp import_feeds(feeds) do
    Enum.map(feeds, &import_feed/1)
  end

  @spec import_feed(feed_outline()) :: UnLib.Source.t()
  defp import_feed(%{type: "feed", url: url} = feed) do
    {:ok, source} = UnLib.Sources.new(url, :rss, feed[:title])
    source
  end

  @spec add_sources_to_account([UnLib.Source.t()], UnLib.Account.t()) :: :ok
  defp add_sources_to_account(sources, account) do
    Enum.each(sources, &UnLib.Sources.add(&1, account))
  end

  @spec pretty_print_added_feeds(UnLib.Account.t()) :: :ok
  defp pretty_print_added_feeds(account) do
    IO.puts("Added the following sources to the #{account.username} account: \n")

    account
    |> UnLib.Sources.list()
    |> Enum.each(&print_item(&1.name))
  end

  @spec print_item(String.t()) :: :ok
  defp print_item(name) do
    IO.puts(IO.ANSI.green() <> "*" <> IO.ANSI.reset() <> " #{name}")
  end
end
