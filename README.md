# IGTS-USER

import com.stratus.presentation.api.constants.Constants;
import com.stratus.presentation.api.exception.OeInvocationException;
import com.stratus.presentation.api.exception.ServiceWarningException;
import com.stratus.presentation.api.exception.UnAuthorizedException;
import com.stratus.presentation.api.message.MessageKeys;
import com.stratus.presentation.api.model.Query;

/**
 * The util class of OeInvocation.
 * 
 */
public class OeInvocationUtil {

    /**
     * Get the OE host URL
     * 
     * @return The OE host URL
     */
    public static String getUrlRoot() {
        StringBuilder sbUrl = new StringBuilder(Constants.HTTP_PROTOCOL);
        sbUrl.append(ConfigManagmentUtil.getCloudMgmtProperty(Constants.CLOUD_MGMT_HOST_PROPS_KEY));
        sbUrl.append(":");
        sbUrl.append(ConfigManagmentUtil.getCloudMgmtProperty(Constants.CLOUD_MGMT_PORT_PROPS_KEY));
        sbUrl.append(ConfigManagmentUtil.getCloudMgmtProperty(Constants.CLOUD_MGMT_BASE_URI_PROPS_KEY));
        return sbUrl.toString();
    }

    /**
     * Send the GET HTTP request
     * 
     * @param readPath
     *            The URI path
     * @param header
     *            The HTTP request header info
     * @param reponseType
     *            The HTTP Response type
     * @return The response of the request
     */
    public static String sendGetRequest(String readPath, Map<String, String> header, String reponseType) {
        return sendGetRequest(readPath, header, reponseType, null);

    }

    /**
     * Send the POST request
     * 
     * @param readPath
     * @param header
     *            The HTTP request header info
     * @param reponseType
     *            The HTTP Response type
     * @param postBody
     *            The HTTP Request body
     * @param bodyType
     *            The HTTP Request body type
     * @return The response of you request
     */
    public static String sendPostRequest(String readPath, Map<String, String> header, String reponseType,
            Object postBody, String bodyType) {
        try {
            Response response = BaseInvocationUtil.sendPostRequest(getUrlRoot(), readPath, header, reponseType,
                    postBody, bodyType);
            String result = handleResponse(response);
            return result;
        } catch (OeInvocationException e) {
            String[] param = { HttpMethod.POST.name(), readPath };
            throw new OeInvocationException(e.getMessage(), MessageKeys.FAILED_TO_REQUEST_OE_API, param, e.getDetails());
        }
    }

    /**
     * Send the POST request
     * 
     * @param readPath
     * @param header
     *            The HTTP request header info
     * @param reponseType
     *            The HTTP Response type
     * @param postBody
     *            The HTTP Request body
     * @param bodyType
     *            The HTTP Request body type
     * @return The response of you request
     */
    public static Response getResponseOfPostRequest(String readPath, Map<String, String> header, String reponseType,
            Object postBody, String bodyType) {
        return BaseInvocationUtil.sendPostRequest(getUrlRoot(), readPath, header, reponseType, postBody, bodyType);

    }

    /**
     * Send the PUT request
     * 
     * @param readPath
     *            The URI path
     * @param header
     *            The HTTP request header info
     * @param reponseType
     *            The HTTP Response type
     * @param postBody
     *            The HTTP Request body
     * @param bodyType
     *            The HTTP Request body type
     * @return The response of you request
     */
    public static String sendPutRequest(String readPath, Map<String, String> header, String reponseType,
            Object postBody, String bodyType) {
        try {
            Response response = BaseInvocationUtil.sendPutRequest(getUrlRoot(), readPath, header, reponseType,
                    postBody, bodyType);
            String result = handleResponse(response);
            return result;
        } catch (OeInvocationException e) {
            String[] param = { HttpMethod.PUT.name(), readPath };
            throw new OeInvocationException(e.getMessage(), MessageKeys.FAILED_TO_REQUEST_OE_API, param, e.getDetails());
        }
    }

    /**
     * Send the DELETE request
     * 
     * @param readPath
     *            The URI path
     * @param header
     *            The HTTP request header info
     * @param reponseType
     *            The HTTP Response type
     * @return The delete response entity String
     */
    public static String sendDeleteRequest(String readPath, Map<String, String> header, String reponseType) {
        try {
            Response response = BaseInvocationUtil.sendDeleteRequest(getUrlRoot(), readPath, header, reponseType);
            String result = handleDeleteResponse(response);
            return result;
        } catch (OeInvocationException e) {
            String[] param = { HttpMethod.DELETE.name(), readPath };
            throw new OeInvocationException(e.getMessage(), MessageKeys.FAILED_TO_REQUEST_OE_API, param, e.getDetails());
        }
    }

    /**
     * Send the GET HTTP request
     * 
     * @param readPath
     *            The URI path
     * @param header
     *            The HTTP request header info
     * @param reponseType
     *            The HTTP Response type
     * @param queryParam
     *            The query params object
     * @return The response of the request
     */
    public static String sendGetRequestForQuery(String readPath, Map<String, String> header, String reponseType,
            Query queryParams) {
        try {
            Response response = BaseInvocationUtil.sendGetRequestForQuery(getUrlRoot(), readPath, header, reponseType,
                    queryParams);
            String result = handleResponse(response);
            return result;
        } catch (OeInvocationException e) {
            String[] param = { HttpMethod.GET.name(), readPath };
            throw new OeInvocationException(e.getMessage(), MessageKeys.FAILED_TO_REQUEST_OE_API, param, e.getDetails());
        }
    }

    /**
     * Send the GET HTTP request
     * 
     * @param readPath
     *            The URI path
     * @param header
     *            The HTTP request header info
     * @param reponseType
     *            The HTTP Response type
     * @param queryParam
     *            The query params object
     * @return The response of the request
     */
    public static String sendGetRequest(String readPath, Map<String, String> header, String reponseType,
            Map<String, Object> queryParams) {
        try {
            Response response = BaseInvocationUtil.sendGetRequest(getUrlRoot(), readPath, header, reponseType,
                    queryParams);
            String result = handleResponse(response);
            return result;
        } catch (OeInvocationException e) {
            String[] param = { HttpMethod.GET.name(), readPath };
            throw new OeInvocationException(e.getMessage(), MessageKeys.FAILED_TO_REQUEST_OE_API, param, e.getDetails());
        }
    }

    /**
     * Handle the HTTP response. Notice: Internal server error (500) will be thrown for 4xx and 5xx of OE invocation
     * result.
     * 
     * @param response
     *            The HTTP response
     * @return The response entity String
     */
    private static String handleResponse(Response response) {
        int originRespCode = response.getStatus();
        String result = null;
        // The range 200-206 expect 204, will read the entity
        if (originRespCode >= Status.OK.getStatusCode() && originRespCode <= Status.PARTIAL_CONTENT.getStatusCode()) {
            if (originRespCode == Status.NO_CONTENT.getStatusCode()) {
                return result;
            } else {
                result = response.readEntity(String.class);
                return result;
            }
        } else if (originRespCode == Status.UNAUTHORIZED.getStatusCode()) {
            throw new UnAuthorizedException("Error 401 Unauthorized", MessageKeys.UNAUTHORIZED);
        } else if (originRespCode == Status.PRECONDITION_FAILED.getStatusCode()) {
            result = response.readEntity(String.class);
            throw new ServiceWarningException(result);
        } else {
            List<Map<String, String[]>> details = new ArrayList<Map<String, String[]>>();
            Map<String, String[]> statusCodeMessage = new HashMap<String, String[]>();
            statusCodeMessage.put(MessageKeys.RESPONSE_STATUS_CODE, new String[] { String.valueOf(originRespCode) });
            details.add(statusCodeMessage);
            throw new OeInvocationException("Failed to request Cloud API", String.valueOf(originRespCode), details);
        }
    }

    /**
     * Handle the HTTP DELETE response. Notice: Internal server error (500) will be thrown for 4xx and 5xx of OE
     * invocation result.
     * 
     * @param response
     *            The HTTP response
     * @return The response entity String
     */
    private static String handleDeleteResponse(Response response) {
        int originRespCode = response.getStatus();
        String result = null;
        // The range 2xx is defined success
        if (originRespCode >= Status.OK.getStatusCode() && originRespCode <= Status.PARTIAL_CONTENT.getStatusCode()) {
            result = response.readEntity(String.class);
            return result != null ? result : StringUtils.EMPTY;
        } else if (originRespCode == Status.UNAUTHORIZED.getStatusCode()) {
            throw new UnAuthorizedException("Error 401 Unauthorized", MessageKeys.UNAUTHORIZED);
        } else if (originRespCode == Status.PRECONDITION_FAILED.getStatusCode()) {
            result = response.readEntity(String.class);
            throw new ServiceWarningException(result);
        } else if (originRespCode == Status.NOT_FOUND.getStatusCode()) {
            return result;
        } else {
            List<Map<String, String[]>> details = new ArrayList<Map<String, String[]>>();
            Map<String, String[]> statusCodeMessage = new HashMap<String, String[]>();
            statusCodeMessage.put(MessageKeys.RESPONSE_STATUS_CODE, new String[] { String.valueOf(originRespCode) });
            details.add(statusCodeMessage);
            throw new OeInvocationException("Failed to request Cloud API", String.valueOf(originRespCode), details);
        }
    }
}

*********************************************************************




public class ConfigManagmentUtil {

    /** SLF4J logger */
    private static final Logger LOGGER = LoggerFactory.getLogger(ConfigManagmentUtil.class);

    /** The config info of cloudmgmt APIs */
    private static Properties cloudMgmtProps;

    static {
        loadConfig();
    }

    private static void loadConfig() {
        if (cloudMgmtProps != null) {
            return;
        }
        // the cloud_mgmt.properties file path
        String filePath = Constants.CLOUD_MGMT_PROPS_FILE;
        InputStream is = null;
        try {
            is = ConfigManagmentUtil.class.getClassLoader().getResourceAsStream(filePath);
            cloudMgmtProps = new Properties();
            cloudMgmtProps.load(is);
        } catch (FileNotFoundException e) {
            LOGGER.error("Can not find file " + filePath, e);
        } catch (IOException e1) {
            LOGGER.error("Failed to load " + filePath, e1);
        } finally {
            try {
                is.close();
            } catch (IOException e) {
                LOGGER.error("Failed to close input stream");
            }
        }
    }

    /**
     * Get the value of the key in cloud_mgmt.properties
     * 
     * @return the value of the key in cloud_mgmt.properties
     */
    public static String getCloudMgmtProperty(String key) {
        return cloudMgmtProps.getProperty(key);
    }
}
