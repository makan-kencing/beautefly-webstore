package com.lavacorp.beautefly.util.response.dto;

import java.io.Serializable;

public record ValidationError(String path, String message) implements Serializable {
}
