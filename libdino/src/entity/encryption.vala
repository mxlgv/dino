namespace Dino.Entities {

    public enum Encryption {
        NONE,
        PGP,
        OMEMO,
        DTLS_SRTP,
        SRTP,
        UNKNOWN;

        public bool is_some() {
            return this != NONE;
        }

        public static Encryption parse(string str) {
            switch (str) {
                case "DINO_ENTITIES_ENCRYPTION_NONE":
                    return NONE;
                case "DINO_ENTITIES_ENCRYPTION_PGP":
                    return PGP;
                case "DINO_ENTITIES_ENCRYPTION_OMEMO":
                    return OMEMO;
                case "DINO_ENTITIES_ENCRYPTION_DTLS_SRTP":
                    return DTLS_SRTP;
                case "DINO_ENTITIES_ENCRYPTION_SRTP":
                    return SRTP;
                case "DINO_ENTITIES_ENCRYPTION_UNKNOWN":
                    // Fall through.
                default:
                    break;
            }

            return UNKNOWN;
        }
    }

    public enum InterfaceScale {
        NONE,
        SMALL,
        MEDIUM,
        LARGE,
        EXTRA_LARGE;

        public bool is_some() {
            return this != NONE;
        }

        public static InterfaceScale parse(string str) {
            switch (str) {
                case "DINO_ENTITIES_INTERFACE_SCALE_SMALL":
                    return SMALL;
                case "DINO_ENTITIES_INTERFACE_SCALE_MEDIUM":
                    return MEDIUM;
                case "DINO_ENTITIES_INTERFACE_SCALE_LARGE":
                    return LARGE;
                case "DINO_ENTITIES_INTERFACE_SCALE_EXTRA_LARGE":
                    return EXTRA_LARGE;
                default:
                    return NONE;
            }
        }

        public static double to_double(InterfaceScale val) {
            switch (val) {
                case InterfaceScale.SMALL:
                    return 0.6;
                case InterfaceScale.MEDIUM:
                    return 0.8;
                case InterfaceScale.LARGE:
                    return 1;
                case InterfaceScale.EXTRA_LARGE:
                    return 1.5;
                default:
                    return 0.8;
            }
        }

        public static double to_css_pt(InterfaceScale val) {
            switch (val) {
                case InterfaceScale.SMALL:
                    return 8;
                case InterfaceScale.MEDIUM:
                    return 10;
                case InterfaceScale.LARGE:
                    return 12;
                case InterfaceScale.EXTRA_LARGE:
                    return 16;
                default:
                    return 10;
            }
        }
    }

}