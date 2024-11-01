﻿// SPDX-License-Identifier: Apache-2.0
// Licensed to the Ed-Fi Alliance under one or more agreements.
// The Ed-Fi Alliance licenses this file to you under the Apache License, Version 2.0.
// See the LICENSE and NOTICES files in the project root for more information.

using System.Threading.Tasks;
using EdFi.Common;
using EdFi.Ods.Api.Providers;
using EdFi.Ods.Api.Startup;

namespace EdFi.Ods.Features.OpenApiMetadata
{
    public class InitializeOpenApiMetadataCache : IStartupCommand
    {
        private readonly IOpenApiMetadataCacheProvider _openApiMetadataCacheProvider;

        public InitializeOpenApiMetadataCache(IOpenApiMetadataCacheProvider openApiMetadataCacheProvider)
        {
            _openApiMetadataCacheProvider = Preconditions.ThrowIfNull(openApiMetadataCacheProvider, nameof(openApiMetadataCacheProvider));
        }

        public Task ExecuteAsync()
        {
            // Populate the swagger metadata cache at runtime instead of per request.
            _openApiMetadataCacheProvider.ResetCacheInitialization();
            
            return Task.CompletedTask;
        }
    }
}
