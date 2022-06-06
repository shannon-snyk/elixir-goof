defmodule Pow.Operations do
  @moduledoc """
  Operation methods that glues operation calls to context module.

  A custom context module can be used instead of the default `Pow.Ecto.Context`
  if a `:users_context` key is passed in the configuration.
  """
  alias Pow.{Config, Ecto.Context}

  @doc """
  Build a changeset from a blank user struct.

  It'll use the schema module fetched from the config through
  `Pow.Config.user!/1`.
  """
  @spec changeset(map(), Config.t()) :: map() | nil
  def changeset(params, config) do
    user_mod = Config.user!(config)
    user     = user_mod.__struct__()

    changeset(user, params, config)
  end

  @doc """
  Build a changeset from existing user struct.

  It'll call the `changeset/2` method on the user struct.
  """
  @spec changeset(map(), map(), Config.t()) :: map()
  def changeset(user, params, _config) do
    user.__struct__.changeset(user, params)
  end

  @doc """
  Authenticate a user.

  This calls `Pow.Ecto.Context.authenticate/2` or `authenticate/1` on a custom
  context module.
  """
  @spec authenticate(map(), Config.t()) :: map() | nil
  def authenticate(params, config) do
    case context_module(config) do
      Context -> Context.authenticate(params, config)
      module  -> module.authenticate(params)
    end
  end

  @doc """
  Create a new user.

  This calls `Pow.Ecto.Context.create/2` or `create/1` on a custom context
  module.
  """
  @spec create(map(), Config.t()) :: {:ok, map()} | {:error, map()}
  def create(params, config) do
    case context_module(config) do
      Context -> Context.create(params, config)
      module  -> module.create(params)
    end
  end

  @doc """
  Update an existing user.

  This calls `Pow.Ecto.Context.update/3` or `update/2` on a custom context
  module.
  """
  @spec update(map(), map(), Config.t()) :: {:ok, map()} | {:error, map()}
  def update(user, params, config) do
    case context_module(config) do
      Context -> Context.update(user, params, config)
      module  -> module.update(user, params)
    end
  end

  @doc """
  Delete an existing user.

  This calls `Pow.Ecto.Context.delete/2` or `delete/1` on a custom context
  module.
  """
  @spec delete(map(), Config.t()) :: {:ok, map()} | {:error, map()}
  def delete(user, config) do
    case context_module(config) do
      Context -> Context.delete(user, config)
      module  -> module.delete(user)
    end
  end

  @doc """
  Retrieve a user with the provided clauses.

  This calls `Pow.Ecto.Context.get_by/2` or `get_by/1` on a custom context
  module.
  """
  @spec get_by(Keyword.t() | map(), Config.t()) :: map() | nil
  def get_by(clauses, config) do
    case context_module(config) do
      Context -> Context.get_by(clauses, config)
      module  -> module.get_by(clauses)
    end
  end

  defp context_module(config) do
    Config.get(config, :users_context, Context)
  end
end
