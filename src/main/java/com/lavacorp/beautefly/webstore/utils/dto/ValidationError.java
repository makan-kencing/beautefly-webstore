package com.lavacorp.beautefly.webstore.utils.dto;

import java.io.Serializable;

public record ValidationError(String path, String message) implements Serializable {
}
