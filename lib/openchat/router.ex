defmodule OpenChat.Router do
  use Plug.Router

  alias OpenChat.Controllers.{CreateUserController, LoginController, CreatePostController}

  plug(CORSPlug)
  plug(Plug.Parsers, parsers: [:urlencoded, :multipart, :json], json_decoder: Poison)

  plug(:match)
  plug(:dispatch)

  get("/", to: OpenChat.HelloWorldPlug)
  get("/status", do: send_resp(conn, 200, "OK"))

  post("/users",
    to: CreateUserController,
    init_opts: [user_repo: OpenChat.Repositories.UserRepo]
  )

  post("/login",
    to: LoginController,
    init_opts: [user_repo: OpenChat.Repositories.UserRepo]
  )

  post("/users/:user_id/timeline",
    to: CreatePostController,
    init_opts: [post_repo: OpenChat.Repositories.PostRepo]
  )

  # POST /users/:id/timeline { text }
  # 201 - { postId, userId, text, dateTime }
  # 400 - Post contains inappropriate language.

  match(_, do: send_resp(conn, 404, "Not found!!"))
end
