package com.ntu.igts.validator;

import org.springframework.stereotype.Component;

import com.ntu.igts.constants.Constants;
import com.ntu.igts.exception.ServiceWarningException;
import com.ntu.igts.i18n.MessageKeys;
import com.ntu.igts.utils.ValidationUtil;

import net.sf.json.JSONObject;

@Component
public class AuthorizationValidator {

    public void validateLogin(String postBody) {
        JSONObject jsonPostBody = JSONObject.fromObject(postBody).optJSONObject(Constants.LOGIN);
        if (!ValidationUtil.hasKey(jsonPostBody, Constants.USERNAME)
                        || ValidationUtil.isFieldEmpty(jsonPostBody, Constants.USERNAME)
                        || !ValidationUtil.hasKey(jsonPostBody, Constants.PASSWORD)
                        || ValidationUtil.isFieldEmpty(jsonPostBody, Constants.PASSWORD)) {
            throw new ServiceWarningException("Username or password is required.",
                            MessageKeys.USERNAME_OR_PASSWORD_CANNOT_BE_EMPTY);
        }
    }
}
