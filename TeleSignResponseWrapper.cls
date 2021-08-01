/* Class Name : TeleSignResponseWrapper
   Developer Name : Anupam Shrivastava
*/
public with sharing class TeleSignResponseWrapper {
    public String external_id;
    public String reference_id;
    public status status;
    public additional_info additional_info;
    public class status {
        public string code;
        public string updated_on;
        public string description  ;
    }
    public class additional_info {
        public string code_entered;
        public string message_parts_count;
    }
}
