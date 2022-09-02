package gocamping.exception;

public class GCDataInvalidException extends RuntimeException {

		public GCDataInvalidException() {
			super();
		}

		public GCDataInvalidException(String message, Throwable cause) {
			super(message, cause);
		}

		public GCDataInvalidException(String message) {
			super(message);
		}

	}
