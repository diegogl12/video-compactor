ExUnit.start()
Application.ensure_all_started(:mimic)

[
  ExAws,
  ExAws.S3,
  Tesla,
  FFmpex,
  VideoCompactor.InterfaceAdapters.Repositories.VideoRepository,
  VideoCompactor.InterfaceAdapters.Gateways.Clients.VideoManager,
  VideoCompactor.InterfaceAdapters.Gateways.Clients.S3,
  VideoCompactor.InterfaceAdapters.Gateways.Clients.Ffmpex,
  File,
  VideoCompactor.InterfaceAdapters.Controllers.VideoController,
  VideoCompactor.InterfaceAdapters.DTOs.WebVideoResponseDTO,
  VideoCompactor.InterfaceAdapters.DTOs.VideoContentEventDTO,
  VideoCompactor.UseCases.CompactVideo,
  VideoCompactor.Infra.Repo.Mongo,
  VideoCompactor.InterfaceAdapters.Repositories.Schemas.VideoSchema,
  VideoCompactor.Infra.Web.Controllers.VideoController
]
|> Enum.each(&Mimic.copy(&1))
