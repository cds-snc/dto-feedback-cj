package ca.gc.tbs;

import com.google.auth.http.HttpCredentialsAdapter;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.gson.GsonFactory;
import com.google.api.services.sheets.v4.Sheets;
import com.google.api.services.sheets.v4.SheetsScopes;
import com.google.api.services.sheets.v4.model.AppendValuesResponse;
import com.google.api.services.sheets.v4.model.ValueRange;

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

        public static GoogleCredentials getCredentials() throws IOException {
                String envKey = System.getenv("GOOGLE_SERVICE_ACCOUNT_KEY");

                if (envKey == null || envKey.isEmpty()) {
                        throw new IOException("GOOGLE_SERVICE_ACCOUNT_KEY environment variable is missing or empty.");
                }

                return GoogleCredentials
                                .fromStream(new java.io.ByteArrayInputStream(
                                                envKey.getBytes(java.nio.charset.StandardCharsets.UTF_8)))
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
