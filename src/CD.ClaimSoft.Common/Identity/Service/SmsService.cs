﻿using System.Threading.Tasks;

using Microsoft.AspNet.Identity;

namespace CD.ClaimSoft.Common.Identity.Service
{
    public class SmsService : IIdentityMessageService
    {
        public Task SendAsync(IdentityMessage message)
        {
            // Plug in your SMS service here to send a text message.
            return Task.FromResult(0);
        }
    }
}