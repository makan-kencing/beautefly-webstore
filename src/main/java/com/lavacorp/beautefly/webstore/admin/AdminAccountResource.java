package com.lavacorp.beautefly.webstore.admin;

import com.lavacorp.beautefly.webstore.account.mapper.AccountMapper;
import com.lavacorp.beautefly.webstore.common.dto.PaginatedResult;
import com.lavacorp.beautefly.webstore.search.AccountSearchService;
import com.lavacorp.beautefly.webstore.search.dto.AccountSearchParametersDTO;
import com.lavacorp.beautefly.webstore.search.dto.AccountSearchResultDTO;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;

@Path("/admin/account")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class AdminAccountResource {
    @Inject
    private AccountSearchService accountSearchService;

    @Inject
    private AdminAccountService adminAccountService;

    @Inject
    private AccountMapper accountMapper;

    @GET
    @Path("/search")
    public PaginatedResult<AccountSearchResultDTO> searchAccount(@BeanParam AccountSearchParametersDTO search) {
        return accountSearchService.search(search);
    }
}
