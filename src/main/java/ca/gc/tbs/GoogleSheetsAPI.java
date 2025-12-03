package ca.gc.tbs;

import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.gson.GsonFactory;
import com.google.api.services.sheets.v4.Sheets;
import com.google.api.services.sheets.v4.SheetsScopes;
import com.google.api.services.sheets.v4.model.AppendValuesResponse;
import com.google.api.services.sheets.v4.model.ValueRange;
import com.google.auth.http.HttpCredentialsAdapter;
import com.google.auth.oauth2.GoogleCredentials;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.Arrays;
import java.util.Collections;

public class GoogleSheetsAPI {

        static final String spreadsheetId = "1B16qEbfp7SFCfIsZ8fcj7DneCy1WkR0GPh4t9L9NRSg";
        static final String duplicateCommentsSpreadsheetId = "1cR2mih5sBwl3wUjniwdyVA0xZcqV2Wl9yhghJfMG5oM"; // Template
        // ID to
        // be replaced
        static final String range = "A1:A50000";
        private static final String APPLICATION_NAME = "My Google Sheets Application";
        private static final JsonFactory JSON_FACTORY = GsonFactory.getDefaultInstance();

        private static String serviceAccountKey;

        public static void setServiceAccountKey(String key) {
                serviceAccountKey = key;
        }

        public static GoogleCredentials getCredentials() throws IOException {
                // Try injected value first, then fallback to environment variable
                String key = serviceAccountKey != null ? serviceAccountKey
                                : System.getenv("GOOGLE_SERVICE_ACCOUNT_KEY");

                if (key == null || key.isEmpty()) {
                        throw new IOException(
                                        "Google Service Account Key is missing. Set google.service.account.key in application.properties or GOOGLE_SERVICE_ACCOUNT_KEY environment variable.");
                }

                // Handle escaped newlines from properties file or AWS console
                key = key.replace("\\n", "\n");

                return GoogleCredentials
                                .fromStream(new java.io.ByteArrayInputStream(
                                                key.getBytes(java.nio.charset.StandardCharsets.UTF_8)))
                                .createScoped(Collections.singleton(SheetsScopes.SPREADSHEETS));
        }

        public static void appendURL(String url) throws GeneralSecurityException, IOException {
                final NetHttpTransport HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
                GoogleCredentials credential = getCredentials();

                Sheets service = new Sheets.Builder(HTTP_TRANSPORT, JSON_FACTORY,
                                new HttpCredentialsAdapter(credential))
                                .setApplicationName(APPLICATION_NAME)
                                .build();

                ValueRange appendBody = new ValueRange()
                                .setValues(Arrays.asList(
                                                Arrays.asList(url)));
                try {
                        AppendValuesResponse appendResult = service.spreadsheets().values()
                                        .append(spreadsheetId, range, appendBody)
                                        .setValueInputOption("USER_ENTERED")
                                        .setInsertDataOption("INSERT_ROWS")
                                        .setIncludeValuesInResponse(true)
                                        .execute();
                } catch (IOException e) {
                        e.printStackTrace();
                }
        }

        public static void appendDuplicateComment(String date, String timestamp, String url, String comment)
                        throws GeneralSecurityException, IOException {
                final NetHttpTransport HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
                GoogleCredentials credential = getCredentials();

                Sheets service = new Sheets.Builder(HTTP_TRANSPORT, JSON_FACTORY,
                                new HttpCredentialsAdapter(credential))
                                .setApplicationName(APPLICATION_NAME)
                                .build();

                ValueRange appendBody = new ValueRange()
                                .setValues(Arrays.asList(
                                                Arrays.asList(date, timestamp, url, comment)));
                try {
                        AppendValuesResponse appendResult = service.spreadsheets().values()
                                        .append(duplicateCommentsSpreadsheetId, "A1:D50000", appendBody)
                                        .setValueInputOption("USER_ENTERED")
                                        .setInsertDataOption("INSERT_ROWS")
                                        .setIncludeValuesInResponse(true)
                                        .execute();
                } catch (IOException e) {
                        e.printStackTrace();
                }
        }

        public static void main(String[] args) throws GeneralSecurityException, IOException {
                appendURL("test");
        }
}
